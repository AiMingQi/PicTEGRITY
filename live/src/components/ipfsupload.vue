<template>
    <v-content>
        <v-container>
            <v-card class="pa-5">
                <h1>
                    Something
                </h1>
                <v-file-input
                    show-size
                    label="Image"
                    accept=".png,.jpg"
                    v-model="image">

                </v-file-input>
            </v-card>
        </v-container>
    </v-content>
</template>
<script>
// import ipfs from '../ipfs'
import ipfs from '../ipfsapi'
export default {
    data () {
        return {
                image: null

        }
    },
    methods: {
        async bookImgUploadIpfs () {
            console.log("uploading Book Cover to IPFS....")
            ipfs.add(this.bookImgBuffer, (error, result) => {
                if (error || !result) {
                    console.log("Error!")
                    return;
                }
                else {
                    this.bookImgHash = result[0].hash
                    this.bookImgHashUrl = "http://ipfs.io/ipfs/" + this.bookImgHash
                    console.log("Book Cover Loaded to IPFS")
                    return;
                }
            })
        }
    }
}
</script>