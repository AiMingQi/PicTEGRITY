import getIpfs from 'get-ipfs'

let config = {
    // `permissions` are enabled if the browser is ipfs-capable (Opera or extension)
    // passed to `window.ipfs.enable` if available
    // prevents a permission dialog from appearing for every action
    permissions: ['id', 'version', 'add', 'cat', 'dag', 'swarm'],
   
    // `peers` is a list of peer multiaddrs to connect to on load
    // to work with the `js-ipfs` fallback, these must have available websocket ports
    peers: [],
   
    // `browserPeers` is a list of peer multiaddrs to connect to only on fallback to an in-browser js-ipfs daemon
    // note: these must be secure websocket or WebRTC addresses
    browserPeers: [],
   
    // `localPeers` is a list of peer multiaddrs to connect to if using a local ipfs daemon (through ipfs companion for instance)
    localPeers: [],
   
    // (optional) Configure how to load js-ipfs. By default this'll be an unpkg url that points to the latest minified distribution.
    jsIpfs: "https://unpkg.com/ipfs@latest/dist/index.min.js",
    jsIpfs: async () => await import("ipfs"),
    jsIpfs: () => Promise.resolve(Ipfs)
  }
 
const ipfs = await getIpfs(config)