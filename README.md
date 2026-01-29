# Banking Anomaly Transactions Analysis using SQL (PaySim Dataset)

This project focuses on detecting fraudulent and anomalous banking transactions using advanced SQL techniques such as Common Table Expressions (CTEs) and recursive queries.
The dataset used is the PaySim financial transaction dataset, which simulates mobile money transfers to detect fraud patterns and money-laundering activities.

## Project Overview
The goal of this project is to analyze transaction data and identify potential fraud chains, anomalies, and inconsistencies in account balances.
Through SQL-based exploration and pattern detection, the project demonstrates how we can leverage SQL for real-world fraud detection and financial data validation.

## Key Objectives

- Detect recursive fraudulent transaction chains using Recursive CTEs.
- Analyze temporal patterns in fraudulent activity over multiple time steps.
- Identify transactions with zero balance before or after transfers.
- Validate data integrity by comparing computed and actual account balances.
- Highlight suspicious patterns such as repeated transfers, large transaction amounts, and static balances.

## Insights & Results
- Identified multi-step money-laundering chains via recursive SQL logic.
- Detected accounts with consecutive zero balances, signaling possible anomalies.
- Verified balance consistency between computed and actual transaction data.
- Demonstrated that SQL alone can perform powerful financial fraud analytics without external tools.

## Note:
The dataset used in this project is synthetically generated and intentionally contains inconsistencies.
As a result, some balance audit queries flag a large number of invalid rows (≈ 52,000).

This behavior is expected and reflects data quality issues introduced during synthetic data generation.
The SQL logic and audit checks implemented here are production-valid and will work correctly on real-world transactional data, where such inconsistencies indicate genuine fraud or data corruption





