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
import ipfsupload from './components/ipfsupload.vue'

  export default {
    components: {
      ipfsupload
    },
    props: {
      source: String,
    },

    data: () => ({
      drawer: null,
    }),

    created () {
      this.$vuetify.theme.dark = true
    },
  }
</script>