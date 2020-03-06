<template>
  <v-app id="inspire">
    <v-app-bar
      app
      clipped-left
    >
      <v-app-bar-nav-icon @click.stop="drawer = !drawer" />
      <v-toolbar-title>PicTEGRITY - InterPlanetary File System Playground</v-toolbar-title>
    </v-app-bar>

    <v-content>
      <v-container
        class="fill-height"
        fluid
      >
        <v-row
          align="center"
          justify="center"
        >
          <v-col class="shrink">
            <ipfsupload></ipfsupload>
          </v-col>
        </v-row>
      </v-container>
    </v-content>

    <v-footer app>
      <span>&copy; The UniTEGRITY Group LLC 2020</span>
    </v-footer>
  </v-app>
</template>

<script>
// import web3 from '../web3
import "./fortmatic"
import ipfsupload from './components/ipfsupload.vue'
import {store} from './store'

  export default {
    components: {
      ipfsupload
    },
    props: {
      source: String,
    },

    data: () => ({
      drawer: null,
      web3account: null,
      store
    }),

    created () {
      this.$vuetify.theme.dark = true
      // console.log("Window",window.web3);
      this.web3account = window.web3.eth.getAccounts((error, accounts) => {
                console.log(accounts);
                console.log('Web3 Capable Account Found');
                // this.OWNER_ADDRESS = accounts[0]
                this.store.OWNER_ADDRESS = accounts[0];
                this.grabbingAddress = false;
            });
      console.log("What is our web3 address?",this.web3account)
    },
  }
</script>