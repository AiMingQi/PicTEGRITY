
import Fortmatic from 'fortmatic';
// Works for web3 1.0 and pre-1.0 versions
import Web3 from 'web3';

const fm = new Fortmatic('pk_test_6400605A9C86C113');
window.web3 = new Web3(fm.getProvider());