# Exploring Web3 User Behavior Across NFTs and DeFi

**Cross-Protocol On-Chain Analysis (MySQL Project)**

---

## 📌 Overview

This project analyzes how Web3 users interact across **DeFi (DEXs)** and **NFT marketplaces** by examining Ethereum on-chain transactions over a 90‑day period.

Using data from **Dune Analytics** and queries written in **MySQL**, the goal is to identify:

* Wallets active across both sectors
* Transaction and volume patterns
* Gas usage behavior
* Cross‑protocol user flows

This repository is part of my analytics portfolio and demonstrates cross‑protocol blockchain analysis using SQL.

---

## 🎯 Objectives

* Measure **user engagement across DEX and NFT platforms**
* Identify **top wallets, token trends, and volume distribution**
* Analyze **weekly and monthly transaction patterns**
* Examine **gas usage and trade characteristics**
* Extract insights on **cross‑protocol user behavior**

---

## 🗂️ Data Sources

Data was sourced from **Dune Analytics** (Ethereum blockchain):

* `dex.trades` — DEX trade records
* `nft.trades` — NFT transaction records
* `evms.transactions` — Gas usage, status, and transaction metadata

---

## 🔬 Methodology

* Filtered transactions within a **90‑day window**
* Matched activity using shared **tx_hash** and wallet addresses
* Aggregated by:

  * Wallet participation
  * Token movement
  * Time‑based trends
  * Gas usage metrics

This approach captures **true cross‑platform interactions** rather than isolated activity.

---

## 🛠️ Tools & Stack

* **MySQL** — Data extraction & analysis
* **Dune Analytics** — Blockchain data source
* **Microsoft Excel** — Visualization & summaries

---

## 📁 Repository Structure

```
/queries        → Core SQL analysis queries
/data           → Raw or processed datasets
/visuals        → Excel charts and summaries
README.md       → Project overview
```

---

## 📊 Key Findings (High-Level)

* User activity is **highly concentrated** among a small subset of wallets
* There is **significant overlap** between active DeFi traders and NFT participants
* Transaction volume and gas usage are **unevenly distributed**
* Distinct behavioral patterns emerge by transaction type and platform

These results suggest that Web3 user behavior is **cross‑protocol rather than siloed**.

---

## 🚀 How to Use

1. Clone the repository
2. Load datasets into MySQL
3. Run queries in `/queries`
4. Review visualizations in `/visuals`

---

## 👤 Author

**Damilola Fulani**
Data Analyst | Web3 Analytics | Marketing & Strategy

---

## ✨ Notes

This project demonstrates:

* Cross‑protocol behavioral analysis
* Practical blockchain data handling
* SQL‑driven research workflows

Feedback and collaboration are welcome.
