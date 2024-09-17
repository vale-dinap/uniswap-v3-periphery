# Uniswap V3 Periphery – Compatibility Layer

## Overview
This repository contains a fork of the [Uniswap V3 Periphery](https://github.com/Uniswap/v3-periphery) protocol, designed to ensure compatibility with the latest Solidity versions. The primary focus of this fork is to facilitate interaction and integration testing with external smart contracts, while avoiding any modifications to the core logic of Uniswap V3, aside from necessary adjustments for Solidity compiler compatibility.

## Purpose
This compatibility layer has been created with two goals in mind:
- **Ensure Compatibility**: Update the Uniswap V3 core contracts to work seamlessly with Solidity 0.8.x and newer versions, ensuring that external projects do not face version incompatibility issues.
- **Enable Testing**: Provide an environment where developers can test their smart contracts against the Uniswap V3 protocol, using modern Solidity tooling, without needing to modify the protocol's fundamental behavior.

## What’s Included
The repository includes:
- Updated Solidity contracts for compatibility with version 0.8.x and above.

## What’s Not Changed
In keeping with the goal of maintaining the integrity of the original protocol:
- No changes have been made to the core logic or functionality of Uniswap V3, except for those required to ensure compatibility with newer Solidity compiler versions.
- The operational structures remain the same as in the original Uniswap V3 Periphery.

## Directory Structure
A high-level overview of the project structure (Solidity files only):

🔷 Blue diamond: Contracts and libraries

🔶 Orange diamond: Interfaces
```bash
📦contracts
 ┣ 📂base
 ┃ ┣ 🔷BlockTimestamp.sol
 ┃ ┣ 🔷ERC721Permit.sol
 ┃ ┣ 🔷LiquidityManagement.sol
 ┃ ┣ 🔷Multicall.sol
 ┃ ┣ 🔷PeripheryImmutableState.sol
 ┃ ┣ 🔷PeripheryPayments.sol
 ┃ ┣ 🔷PeripheryPaymentsWithFee.sol
 ┃ ┣ 🔷PeripheryValidation.sol
 ┃ ┣ 🔷PoolInitializer.sol
 ┃ ┗ 🔷SelfPermit.sol
 ┣ 📂examples
 ┃ ┗ 🔷PairFlash.sol
 ┣ 📂interfaces
 ┃ ┣ 📂external
 ┃ ┃ ┣ 🔶IERC1271.sol
 ┃ ┃ ┣ 🔶IERC20PermitAllowed.sol
 ┃ ┃ ┗ 🔶IWETH9.sol
 ┃ ┣ 🔶IERC20Metadata.sol
 ┃ ┣ 🔶IERC721Permit.sol
 ┃ ┣ 🔶IMulticall.sol
 ┃ ┣ 🔶INonfungiblePositionManager.sol
 ┃ ┣ 🔶INonfungibleTokenPositionDescriptor.sol
 ┃ ┣ 🔶IPeripheryImmutableState.sol
 ┃ ┣ 🔶IPeripheryPayments.sol
 ┃ ┣ 🔶IPeripheryPaymentsWithFee.sol
 ┃ ┣ 🔶IPoolInitializer.sol
 ┃ ┣ 🔶IQuoter.sol
 ┃ ┣ 🔶IQuoterV2.sol
 ┃ ┣ 🔶ISelfPermit.sol
 ┃ ┣ 🔶ISwapRouter.sol
 ┃ ┣ 🔶ITickLens.sol
 ┃ ┗ 🔶IV3Migrator.sol
 ┣ 📂lens
 ┃ ┣ 🔷Quoter.sol
 ┃ ┣ 🔷QuoterV2.sol
 ┃ ┣ 🔷TickLens.sol
 ┃ ┗ 🔷UniswapInterfaceMulticall.sol
 ┣ 📂libraries
 ┃ ┣ 🔷BytesLib.sol
 ┃ ┣ 🔷CallbackValidation.sol
 ┃ ┣ 🔷ChainId.sol
 ┃ ┣ 🔷HexStrings.sol
 ┃ ┣ 🔷LiquidityAmounts.sol
 ┃ ┣ 🔷NFTDescriptor.sol
 ┃ ┣ 🔷NFTSVG.sol
 ┃ ┣ 🔷OracleLibrary.sol
 ┃ ┣ 🔷Path.sol
 ┃ ┣ 🔷PoolAddress.sol
 ┃ ┣ 🔷PoolTicksCounter.sol
 ┃ ┣ 🔷PositionKey.sol
 ┃ ┣ 🔷PositionValue.sol
 ┃ ┣ 🔷SqrtPriceMathPartial.sol
 ┃ ┣ 🔷TokenRatioSortOrder.sol
 ┃ ┗ 🔷TransferHelper.sol
 ┣ 📂test
 ┃ ┣ 🔷Base64Test.sol
 ┃ ┣ 🔷LiquidityAmountsTest.sol
 ┃ ┣ 🔷MockObservable.sol
 ┃ ┣ 🔷MockObservations.sol
 ┃ ┣ 🔷MockTimeNonfungiblePositionManager.sol
 ┃ ┣ 🔷MockTimeSwapRouter.sol
 ┃ ┣ 🔷NFTDescriptorTest.sol
 ┃ ┣ 🔷NonfungiblePositionManagerPositionsGasTest.sol
 ┃ ┣ 🔷OracleTest.sol
 ┃ ┣ 🔷PathTest.sol
 ┃ ┣ 🔷PeripheryImmutableStateTest.sol
 ┃ ┣ 🔷PoolAddressTest.sol
 ┃ ┣ 🔷PoolTicksCounterTest.sol
 ┃ ┣ 🔷PositionValueTest.sol
 ┃ ┣ 🔷SelfPermitTest.sol
 ┃ ┣ 🔷TestCallbackValidation.sol
 ┃ ┣ 🔷TestERC20.sol
 ┃ ┣ 🔷TestERC20Metadata.sol
 ┃ ┣ 🔷TestERC20PermitAllowed.sol
 ┃ ┣ 🔷TestMulticall.sol
 ┃ ┣ 🔷TestPositionNFTOwner.sol
 ┃ ┣ 🔷TestUniswapV3Callee.sol
 ┃ ┗ 🔷TickLensTest.sol
 ┣ 🔷NonfungiblePositionManager.sol
 ┣ 🔷NonfungibleTokenPositionDescriptor.sol
 ┣ 🔷SwapRouter.sol
 ┗ 🔷V3Migrator.sol
```

## Installation
To use this compatibility layer for testing or integrating external projects:

### 1. Clone the Repository:
```bash
git clone https://github.com/vale-dinap/uniswap-V3-periphery.git
```

### 2. Install Dependencies:
Make sure you have installed the necessary dependencies by running:
```bash
yarn install
```

### 3. Compile Contracts:
Ensure the Solidity compiler version is compatible with the updated contracts:
```bash
forge build
```

### 4. Run Tests:
Test the contracts using Foundry or your preferred testing framework:
```bash
forge test
```

## Contributing
Contributions are welcome, especially if they help to further improve compatibility or testing capabilities. Please open an issue or a pull request if you encounter bugs, or if you have suggestions for improvements.

## License
This project is licensed under the same terms as the original Uniswap V3 Periphery. All rights to the original Uniswap V3 Periphery code remain with [Uniswap Labs](https://uniswap.org/).