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
                    <v-text-field v-model="dateRecorded" label="Date" :placeholder="now"></v-text-field>
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
import moment from 'moment'
// import axios from 'axios'
import '../fortmatic'
import {store} from '../store'
import abi from '../contracts/PicTEGRITY.json';

export default {
    data () {
        return {
                image: null,
                imageBuffer: null,
                imageHash: null,
                rules: [v => v.length <= 360 || 'Max 360 characters'],
                fileName: 'PicTEGRITY',
                dateRecorded: '',
                longDescription: 'This image has been stored in the InterPlanetary File System - IPFS',
                imageHashUrl: '',
                listingStuffJson: {},
                store
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
            ipfs.add(this.imageBuffer, {pin: true}, (error, result) => {
                if (error || !result) {
                    console.log("Error!")
                    return;
                }
                else {
                    this.imageHash = result[0].hash
                    this.imageHashUrl = "https://ipfs.io/ipfs/" + this.imageHash
                    console.log("Book Cover Loaded to IPFS")
                    return;
                }
            })
        },
        createJson () {
            let listingStuff = {
                "N": this.fileName,
                "T": this.rawNow,
                "D": this.longDescription,
                "U": this.imageHashUrl
            }
            this.listingStuffJson = listingStuff
            // console.log("Book Listing", listingStuff)
            // const listingJson = JSON.stringify(listingStuff)
            // console.log(listingJson)
            // this.listingJsonString = listingJson
            // return listingJson;
        },
        async storeOnChain () {
            const address = this.store.selectedContractAddress // Your account address goes here
            console.log("Getting batch at address: " + address);
            var randomString = await new window.web3.eth.Contract(abi, address);
            // var returnedString = await randomString.methods.set("Testing").call();
            var TokenSuccess = await randomString.methods.set(JSON.stringify(this.listingStuffJson)).send({ gasLimit: "1000000",  from: this.store.OWNER_ADDRESS });
            // this.returnedString = returnedString
            // this.currentEthImageUrl = TokenSuccess
            console.log("Set To Ethereum Success", TokenSuccess)
            // return newBatch;
            // let getString = await ContractTasks.Get(g_Web3, address);
            // console.log("String from Ethereum", getString)
        }
       
    },
    computed: {
        bookListingJSON: function () {
            const listingJson = JSON.stringify(this.arr)
            return listingJson
        },
        rawNow: function () {
            let now = Date.now()
            return now;
        },
        now: function () {
            let now = Date.now()
            let formatedNow = moment(now).format('MMMM Do YYYY, h:mm:ss a');
            return formatedNow;
        }
    }
}
</script>