<template>
    <v-content>
        <v-container>
            <v-card class="pa-5" style="min-width: 600px">
                <h1>
                    IPFS Image Uploader
                </h1>
                <v-file-input
                    show-size
                    label="Image"
                    accept=".png,.jpg"
                    v-model="image">

                </v-file-input>
                <v-card-actions>
                    <v-btn @click="uploadImage">
                        Upload Image to IPFS
                    </v-btn>
                </v-card-actions>
            </v-card>
            <v-card class="pa-5">
                <h2>
                    Image Review
                </h2>
                <v-img :src="imageHashUrl" v-if="imageHashUrl" max-width="600px"></v-img>
                <h3>Url of Image: {{imageHashUrl}}</h3>
                <a :href="imageHashUrl" target="_blank" rel="noopener">Link</a>
            </v-card>
            <v-card>
                <v-card-title>
                    <h2>Your Details</h2>
                </v-card-title>
                <v-card-text>
                    <v-text-field v-model="fileName" label="File Name"></v-text-field>
                    <v-text-field v-model="dateRecorded" label="Date"></v-text-field>
                    <v-textarea v-model="longDescription" label="Description" :rules="rules" counter="360"></v-textarea>
                    <v-btn class="black--text" @click="createJson" color="blue" block large>Create JSON</v-btn>
                    <p>{{listingStuffJson}}</p>
                </v-card-text>
                <v-card-actions>
                    <v-btn class="black--text" @click="storeOnChain" color="orange" block large>Store on Blockchain</v-btn>
                </v-card-actions>
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
                image: null,
                imageBuffer: null,
                imageHash: null,
                imageHashUrl: null,
                rules: [v => v.length <= 360 || 'Max 360 characters'],
                fileName: '',
                dateRecorded: '',
                longDescription: '',
                listingStuffJson: {}
        }
    },
    methods: {
        uploadImage () {
            const reader = new FileReader;
            reader.readAsArrayBuffer(this.image);
            console.log("Buffering...", this.image)
            reader.onloadend = () => {
                this.imageBuffer = Buffer(reader.result)
                // var arrayBuffer = reader.result;
                // this.fileBuffer = new Uint8Array(arrayBuffer);
            console.log("Buffer: ", this.imageBuffer);
            this.imgUploadIpfs();
            }
        },
        async imgUploadIpfs () {
            console.log("uploading Book Cover to IPFS....")
            ipfs.add(this.imageBuffer, (error, result) => {
                if (error || !result) {
                    console.log("Error!")
                    return;
                }
                else {
                    this.imageHash = result[0].hash
                    this.imageHashUrl = "http://ipfs.io/ipfs/" + this.imageHash
                    console.log("Book Cover Loaded to IPFS")
                    return;
                }
            })
        },
        createJson () {
            let listingStuff = {
                "fileName": this.fileName,
                "fileDate": this.dateRecorded,
                "description": this.longDescription,
                "imageUrl": this.imageHashUrl
            }
            this.listingStuffJson = listingStuff
            // console.log("Book Listing", listingStuff)
            // const listingJson = JSON.stringify(listingStuff)
            // console.log(listingJson)
            // this.listingJsonString = listingJson
            // return listingJson;
        },
        storeOnChain () {
            console.log('Store on Chain')
        }
    }
}
</script>