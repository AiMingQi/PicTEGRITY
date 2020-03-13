# Contract for managing a publisher, author, developer, consumer relationship

#Stake params
struct StakeManager:
    authorStakeWeightMax: int128
    authorStakeWeightMin: int128
    developerStakeWeightMax: int128
    developerStakeWeightMin: int128
    arbitratorStakeWeightMax: int128
    arbitratorStakeWeightMin: int128
    consumerStakeMax: wei
    consumerStakeMin: wei

#Publisher params
struct Publisher:
    #Address set by Publisher to receive Publisher Royalties
    delegatedPublisher: address
    # Remainder after Author, Developer, and Arbitrator delegations
    stakeWeight: int128

#Author params
struct Author:
    #Address set by Publisher to receive Author Royalties
    delegatedAuthor: address
    #Limited by authorStakeWeightMax and authorStakeWeightWeightMin
    #Required for Author to receive Royalties
    stakeWeight: int128

#Developer params
struct Developer:
    #Address set by Publisher to receive Developer Royalties
    delegatedDeveloper: address
    #Limited by developerStakeWeightMax and developerStakeWeightMin
    #Required for Developer to receive Royalties
    stakeWeight: int128

#Content params
struct Content: 
    #IPFS address of metadata
    content: bytes[46]
    #Count of Reviews
    reviewCount: int128

#Review params    
struct Review:
    #IPFS address of Review Metadata
    reviewMetadata: bytes[46]

#Consumer params
struct Consumer
    #Limited by consumerStakeMin on Consumer Registration
    #Required to Consume Content
    stake: int128

#Arbitrator params
struct Arbitrator
    #Address set by Publisher to administrate Arbitration
    delegatedArbitrator: address
    #Set by Publisher on Arbitrator Registration
    stakeWeight: int128

#Blacklist of consumers who are prevented from consuming content due to bad behavior
#Set by Arbitrator
blacklist: public(map(address, Consumer))

#IPFS address of metadata
metadata: bytes[46]

#Map of published Reviews
reviews: public(map(address, Review)

#Current Price of Content to Consumer
price: public(wei)

#Availability of Content to Consumer
available: bool

#Contract Lock controlled by Arbitrator
locked: bool

#Events
# Events of the contract

# Example
# Transfer: event({_from: indexed(address), _to: indexed(address), _value: uint256})
# Approval: event({_owner: indexed(address), _spender: indexed(address), _value: uint256})
# Transfer some tokens from message sender to another address
# def transfer(_to : address, _value : uint256) -> bool:
#    ... Logic here to do the real work ...
#    # All done, log the event for listeners
#    log.Transfer(msg.sender, _to, _amount)




#Setup global variables
@public
def __init__():

Set Developer Rate
Set Author Rate
Set Arbitrator Rate

#Contract Methods

Register Publisher
Register Developer
Register Author
Register Arbitrator

#Manage Backend Stake

#Manage Publisher Stake
Add Publisher Stake
Return Publisher Stake

#Manage Author Stake
Add Author Stake
Return Author Stake

#Manage Developer Stake
Add Developer Stake
Return Developer Stake

#Manage Arbitrator Stake
Add Arbitrator Stake
Return Arbitrator Stake

#Create Content Listing

#Register Content Location in IPFS
Add Content
#Register Metadata Location in IPFS
Add Metadata
Get Metadata

#Pricing and Availability

#Pricing Controls
Set Price
Get Price
#Availability Controls
Set Availability
Get Availability

#Arbitration Functions
Lock Contract
Blacklist Address
Get Blacklist List
Release Blacklist Address
Release Blacklist All

#Manage Consumer
Register Consumer
Add Consumer Stake
Return Consumer Stake

#Fulfill Content
Unlock Content
Verify Consumption
Issue NFT

#Add Consumer Reviews to Content Listing
#Require Consumer to have appropriate NFT
Add Review
Get Reviews

