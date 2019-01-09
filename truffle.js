// Allows us to use ES6 in our migrations and tests.
require('babel-register')

const HDWalletProvider = require('truffle-hdwallet-provider');
const infuraKey = "e810f7418f774ee7b6d0dac5cdc73613";

const mnemonic = "artwork primary kit distance monitor canyon happy wild course sphere swallow bind"

module.exports = {
  networks: {
    ganache: {
      host: '127.0.0.1',
      port: 9545,
      network_id: '*' // Match any network id
    },
    rinkeby: {
      provider: () => new HDWalletProvider(mnemonic, `https://rinkeby.infura.io/v3/${infuraKey}`),
      network_id: 4,
      gas: 4500000,
      gasPrice: 10000000000
    }
  },
  compilers: {
    solc: {
      version: '^0.4.24'
    }
  }
}
