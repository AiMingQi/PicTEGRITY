import Web3 from "web3";
import Web3Connect from "web3connect";
import Portis from "@portis/web3"
import Fortmatic from "fortmatic";
import WalletConnectProvider from "@walletconnect/web3-provider"

const providerOptions = {
  walletconnect: {
    package: WalletConnectProvider,
    options: {
      infuraId: process.env.VUE_APP_REACT_APP_INFURA_ID
    }
  },
  portis: {
    package: Portis,
    options: {
      id: process.env.VUE_APP_REACT_APP_PORTIS_ID
    }
  },
  fortmatic: {
    package: Fortmatic,
    options: {
      key: process.env.VUE_APP_YOUR_FORTMATIC_TESTNET_API_KEY
    }
  }
}

const web3Connect = new Web3Connect.Core({
  network: "rinkeby", // optional
  cacheProvider: true, // optional
  providerOptions // required
});

const provider = await web3Connect.connect();

window.web3 = new Web3(provider);
console.log(web3)

export default web;