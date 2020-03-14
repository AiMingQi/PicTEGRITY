# Contract for managing a Publisher, Author, Developer, Consumer Relationship with Arbitration
# @author Mitchell Valentine with The UniTEGRITY Group LLC
# @notice This Contract is designed to power the future of digital content consumption with a major concern for the Publisher, Author, and Developer receiving a fair stake in the success of the contract's execution while allowing for arbitration when needed.
# @dev Remember to get your address registered in the delegatedDeveloper slot, The UniTEGRITY Group appreciates when developers leave our address as the main contributor of code, and give themselves a reasonable percentage based on what they can negotiate with the publisher. 


#Publisher params
struct Publisher:
    #Address set by Publisher to receive Publisher Royalties
    #Publisher is the general administrator and has rights to most public functions
    delegatedPublisher: address
    # Remainder after Author, Developer, and Arbitrator delegations
    stakeWeight: int128

#Author params
struct Authors:
    #Address set by Publisher to receive Author Royalties
    #Authors can create Content
    delegatedAuthors: map(address, stakeWeight)
    #Limited by authorStakeWeightMax and authorStakeWeightWeightMin
    #Required for Author to receive Royalties
    stakeWeight: int128

#Developer params
struct Developers:
    #Address set by Publisher to receive Developer Royalties
    #Developers have no access to public methods other than Return Developer Royalties and those available to anyone
    delegatedDevelopers: map(address, stakeWeight)
    #Limited by developerStakeWeightMax and developerStakeWeightMin
    #Required for Developer to receive Royalties
    stakeWeight: int128

#Content params
struct Content: 
    #IPFS address of Content
    content: bytes[46]
    #Count of Reviews
    reviewCount: int128
    #IPFS address of metadata
    contentMetadata: bytes[46]
    #Current Price of Content to Consumer
    price: wei

#Review params    
struct Review:
    #IPFS address of Review Metadata
    reviewMetadata: bytes[46]

#Consumer params
struct Consumer:
    #User Must Agree to Terms
    userAgreements: bool

    #Limited by consumerStakeMin on Consumer Registration
    #Required to Consume Content
    stake: wei

    #Unlock Content Keys Index
    unlockContentKeysIndex: map(int128) 

    #Map of NFT addresses
    verificationTokens: map(address)

    #Map of Reviews Consumer flagged as Public
    publicReviews: map(address)

    #Boolean of whether or not Consumer is on the blacklist
    #default to True
    approvedForConsumption: bool

#Fulfillment
struct UnlockContent:
    #Location of encryption key for Consumer to access content
    keyOracle: address
    #Unlock Content Keys Index
    unlockContentKeysIndex: map(int128) 

#Arbitrator params
struct Arbitrator
    #Address set by Publisher to administrate Arbitration
    delegatedArbitrator: address
    #Set by Publisher on Arbitrator Registration
    stakeWeight: int128

#List of registered Content
contentList: public(map(Content))

#List of registered Consumers
consumerList: map(Consumer)

#Blacklist of Consumers who are prevented from Consuming Content due to Agreement violations
#Set by Arbitrator or Publisher
blackList: public(map(Consumer))

#Map of published Reviews
reviewsList: public(map(Review)

#Stake params
authorStakeWeightMax: int128
authorStakeWeightMin: int128
developerStakeWeightMax: int128
developerStakeWeightMin: int128
arbitratorStakeWeightMax: int128
arbitratorStakeWeightMin: int128
consumerStakeMax: wei
consumerStakeMin: wei

#Availability of Content to Consumer
available: bool

#Contract Lock controlled by Arbitrator
locked: bool

#Events
# Events of the contract
Content Published
Content Availability Change
Review Published 
Price Changed
Consumption Verification Complete 
Contract Locked
NFT Issued

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
Validate Remainder

#Contract Methods
#Developers are generally asserted away from performing any functions other than Add Developer Stake, Return Developer Stake, and those available to anyone including becoming a Consumer.

#Only Publisher or Arbitrator can Register
Register Publisher
#Only Publisher or Arbitrator can Register
Register Developer
    Default to Publisher
#Only Publisher or Arbitrator can Register
Register Author
    Default to Publisher
#Only Publisher can Register
Register Arbitrator
    Default to Publisher

#Manage Backend Stake

#Manage Publisher Stake
#Only Publisher can perform
@payable
Add Publisher Stake

#Only Publisher or Arbitrator can perform
@public
Return Publisher Stake

#Manage Author Stake
#Only Publisher, Arbitrator or Author can perform
@payable
Add Author Stake

#Only Publisher, Arbitrator or Author can perform
@public
Return Author Stake

#Manage Developer Stake
#Only Publisher, Arbitrator or Developer can perform
@payable
Add Developer Stake

#Only Publisher, Arbitrator or Developer can perform
@public
Return Developer Stake

#Manage Arbitrator Stake
#Only Publisher or Arbitrator can perform
@payable
Add Arbitrator Stake

#Only Publisher or Arbitrator can perform
@public
Return Arbitrator Stake

#Create Content Listing

#Register Content Location in IPFS
#Only Author or Publisher can Perform
@public
Add Content

#Key Provider Initializization
@public
Establish Key Provider

#Register Metadata Location in IPFS
#Only Author or Publisher can Perform
@public
Add Metadata

#Corresponding Event to add easy Indexing
@public
Get Metadata

#Pricing and Availability

#Pricing Controls
#Only Publisher or Pricing Contract Interface can Perform
#Acts on Content.price
@public
Set Price

@public
Get Price
#Availability Controls
#Only Author, Publisher and Arbitrator can perform
@private
Set Availability

@public
Get Availability

#Arbitration Functions
#Only Publisher or Arbitrator can perform
@private
Lock Contract

@private
Request Arbitration

#Boolean of Locked State
@public
Get Locked State

#Only Publisher or Arbitrator can perform
@private
Blacklist Address

@public
Get Blacklist List

#Only Publisher or Arbitrator can perform
@private
Release Blacklist Address
#Only Publisher or Arbitrator can perform
@private
Release Blacklist All

#Manage Consumers
#Payable
#Only Consumer can perform
#Default to approvedForConsumption: True
@public
Register Consumer Address to Consumers

#Anyone can perform
@payable
@public
Add Consumer Stake

# Consumer, Publisher, or Arbitrator can perform
#For Consumer to Return Stake all UnlockContent Key Verifications must be resolved.
@public
Return Consumer Stake

#Only Publisher and Arbitrator can perform
@public
Get Consumer List

#Fulfill Content
#Only Consumer can perform
#Requires Content with an Encryption Key Oracle and a Registered Consumer with sufficient Stake
@public
Initiate Content Purchase

#Upon Purchase initiation 
#Utilize UnlockContent Oracle to receive Encryption Key
@private
Unlock Content Key Generation

#Get Content
@private
Get Content

#Once the Consumer has recieved the Unlock Content Key  from the Oracle and the Content from IPFS they submit their Accept Content Key Verification to purchase further Content.
#By selecting to Reject Content Verification the Consumer is Requesting Arbitration
#Until Consumption Verification is Complete, Consumer cannot Unlock further Content or Return their Stake
@public
Accept Content Key Verification

#Only Consumer can perform
#Initiates Request for Arbitration
#Locks Consumer Stake until Resolution
@public
Reject Content Key Verification

#Utilize Price to Consume Stake upon Unlock Content Key Verification
#Requires Accept Content Key Verification
@private
Consume Stake

#Distribute Stake to Author, Developer, Arbitrator, and Publisher based on stakeWeight
#Triggered by Consume Stake
@private
Distribute Stake

#Token references/requires Consumption Verification
@private
Issue NFT

#Add Consumer Reviews to Content Listing
#Only Consumer can perform
#Require Consumer to have appropriate NFT
#Consumer can flag Public or Private to have their address included in the Review Registry
@private
Add Review

#Get List of all reviews; this is intended to display reviews with verifiability without requiring user to share personal identifable information (pii).
@public
Get Reviews

