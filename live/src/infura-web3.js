
/* eslint-disable no-console */
import Web3 from 'web3';

const rpcURL = new Web3.providers.HttpProvider('https://rinkeby.infura.io/v3/'+process.env.VUE_APP_REACT_APP_INFURA_ID)
window.web3 = new Web3(rpcURL)

console.log(web3);
export default web3;