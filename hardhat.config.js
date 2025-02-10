require("hardhat-docgen");
require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

module.exports = {
  solidity: {
    version: "0.8.20",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
  networks: {
    hardhat: {},
    sepolia: {
      url: process.env.SEPOLIA_RPC_URL,
      accounts: process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : [],
      chainId: 11155111, // Sepolia chain ID
      timeout: 100000    // Increase timeout in case of slow RPC responses
    }
  },
  docgen: {
    path: './docs',  // Documentation will be generated here
    clear: true,
    runOnCompile: true,
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY
  },
};
