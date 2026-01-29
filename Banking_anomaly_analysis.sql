-- Detecting recursive fraudelent transactions using recursive CTEs
use paysim;

WITH RECURSIVE fraud_chain AS (
    SELECT
        nameOrig AS origin,
        nameDest AS current_account,
        step,
        amount,
        1 AS chain_level,
        CAST(CONCAT(nameOrig, ' -> ', nameDest) AS CHAR(2000)) AS chain_path
    FROM transactions
    WHERE isFraud = 1
      

    UNION ALL

    SELECT
        fc.origin,
        t.nameDest,
        t.step,
        t.amount,
        fc.chain_level + 1,
        CAST(CONCAT(fc.chain_path, ' -> ', t.nameDest) AS CHAR(2000))
    FROM fraud_chain fc
    JOIN transactions t
      ON fc.current_account = t.nameOrig
     AND t.step > fc.step
    WHERE fc.chain_level < 10
)
SELECT *
FROM fraud_chain;


-- Analysis of rolling_fraud over last 4 steps

with rolling_fraud as (
    select nameOrig, step,
        SUM(isFraud) OVER (PARTITION BY nameOrig ORDER BY step ROWS BETWEEN 4 PRECEDING AND CURRENT ROW
        ) as fraud_rolling
    from transactions
)
Select * 
From rolling_fraud
where fraud_rolling > 0;



-- Complex fraud like large trasfers, consecutive transactions without balance change, and flagged transactions.

with large_transfers AS (
    Select nameOrig, step, amount
    From transactions
    where type = 'TRANSFER' AND amount > 500000
),
no_balance_change AS (
    select nameOrig, step, oldbalanceOrg, newBalanceOrig
    from transactions
    where oldbalanceOrg = newBalanceOrig
),
flagged_transactions AS (
    select nameOrig, step
    from transactions
    where isFlaggedFraud = 1
)
select lt.nameOrig
from large_transfers lt
join no_balance_change nbc
  on lt.nameOrig = nbc.nameOrig and lt.step = nbc.step
join flagged_transactions ft
  on lt.nameOrig = ft.nameOrig and lt.step = ft.step;
  
  
  
  
-- Transactions where the receiver account had a zero balance before or after the transaction.
select nameOrig as sender_account,
    nameDest as receiver_account,
    oldBalanceDest,
    newBalanceDest,
    amount,
    step,type
from transactions
where oldBalanceDest = 0 or newBalanceDest = 0;



-- Transactions where computed new_updated_Balance is not same as the actual newbalanceDest in the table

with CTE as (
select
amount, nameOrig, oldbalanceDest, newbalanceDest,
        (amount + oldbalanceDest) as new_updated_Balance, isFlaggedFraud, isFraud
from transactions)

select * from cte
where new_updated_Balance = newbalanceDest;



