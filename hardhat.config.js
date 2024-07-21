require("@matterlabs/hardhat-zksync-solc");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  zksolc: {
    version: "1.3.9",
    compilerSource: "binary",



    // //testnet
    // defautNetworks: 'goerli',
    // networks: {
    //   hardhat: {},
    //   goerli: {
    //     url: 'https://goerli.infura.io/v3/YOUR_INFURA_PROJECT_ID',
    
    //     // acct used to deploy smart contract, used to sign and send transactions.
    //     accounts: ['0xYOUR_PRIVATE_KEY']
    //   }
    // }

    //  Hardhat, which is used in Ethereum development to compile, deploy, test, and debug Ethereum software. The Hardhat network is a local Ethereum network used for testing and development. It runs in memory and does not persist between runs.
    // For rapid development and testing without the need for internet connectivity or actual tokens.




    settings: {
      optimizer: {
        enabled: true,
      },
    },
  },
  networks: {
    zksync_testnet: {
      url: "https://zksync2-testnet.zksync.dev",
      ethNetwork: "goerli",
      chainId: 280,
      zksync: true,
    },
    zksync_mainnet: {
      url: "https://zksync2-mainnet.zksync.io/",
      ethNetwork: "mainnet",
      chainId: 324,
      zksync: true,
    },
  },
  paths: {
    artifacts: "./artifacts-zk",
    cache: "./cache-zk",
    sources: "./contracts",
    tests: "./test",
  },
  solidity: {
    version: "0.8.17",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
};
