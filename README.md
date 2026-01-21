# Linear Bonding Curve AMM

This repository implements a **Continuous Token Model** using a linear bonding curve. In this model, the smart contract itself acts as the counterparty for every trade, minting tokens when users "buy" and burning them when they "sell."

### Mathematical Formula
The price ($P$) of the token is determined by its current supply ($S$):
$$P = mS + b$$
* **m**: The slope (price increase per token).
* **b**: The floor price (starting price at zero supply).

### Key Features
* **Instant Liquidity:** No need for order books or external liquidity providers.
* **Fair Discovery:** The price is hardcoded and transparent, preventing hidden manipulation.
* **Reserve Backed:** Every token in circulation is backed by a proportional amount of the reserve asset (e.g., ETH/USDC) held in the contract.

### Workflow
1.  **Buy:** Send Reserve Assets -> Contract calculates token amount -> Mints new tokens to user.
2.  **Sell:** Send Tokens -> Contract calculates reserve value -> Burns tokens -> Returns Reserve Assets to user.
