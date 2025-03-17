
# ERC20 Token Contract

## Overview

The `OurToken` contract is a simple implementation of an ERC20 token. This contract allows users to create their own custom tokens with a specified name, symbol, and initial supply. It uses OpenZeppelin's ERC20 contract to ensure a secure and standardized implementation.

## Contract Details

The `OurToken` contract inherits from OpenZeppelin's `ERC20` implementation, which means it provides all the standard features of an ERC20 token, including:

- **Name**: "OurToken"
- **Symbol**: "OT"
- **Initial Supply**: The amount specified during deployment

Upon deployment, the contract automatically mints the initial supply of tokens to the address that deploys the contract.

### Example Token Contract

```solidity
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract OurToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("OurToken", "OT") {
        _mint(msg.sender, initialSupply);
    }
}
```

### Functions

- **constructor(uint256 initialSupply)**: Mints the initial supply to the address deploying the contract.

### Usage

Once deployed, users can interact with the contract by performing standard ERC20 operations, such as:

- Transferring tokens between accounts
- Checking balances of accounts

## Makefile Commands

This project includes a `Makefile` that simplifies common development tasks. Here are the available commands:

- `make install`: Installs the required dependencies.
- `make deploy`: Deploys the token contract to a local Ethereum network.
- `make deploy-sepolia`: Deploys the token contract to the Sepolia network.
- `make deploy-zk`: Deploys the token contract to the zkSync network.
- `make test`: Runs tests to ensure the token contract works as expected.
- `make clean`: Cleans the project by removing generated files.
- `make format`: Formats the code.
- `make update`: Updates the project dependencies.

## Getting Started

### Installation

1. Clone the repository.
2. Install the required dependencies by running:

```bash
make install
```

### Deploying the Token

To deploy the token contract to a network, use:

```bash
make deploy
```

You can specify the network (e.g., Sepolia or zkSync) with the corresponding command.

### Running Tests

Ensure the contract works as expected by running the tests:

```bash
make test
```

### Interacting with the Token

Once deployed, you can interact with your custom token via standard ERC20 operations like transferring tokens and checking balances.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
