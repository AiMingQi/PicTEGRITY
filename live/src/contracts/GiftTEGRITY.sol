pragma solidity ^0.6.4;

contract GiftTEGRITY {
    address payable artist;
    address payable donee;
    address payable buyer;
    uint256 minPrice;
    uint256 depositArtist;
    uint256 depositDonee;
    bool available;
    bool shipped;
    bool received;
    bool returned;
    bool returnAccepted;
    modifier onlyArtist(){
        require(msg.sender == artist,"Must be the Artist");
        _;
    }
    modifier onlyDonee(){
        require(msg.sender == donee,"Must be the Donee");
        _;
    }
    modifier onlyBuyer(){
        require(msg.sender == buyer,"Must be the Buyer");
        _;
    }
    constructor (address payable _donee, uint256 _minPrice) public {
        artist = msg.sender;
        donee = _donee;
        minPrice = _minPrice;
    }
    function purchase() public payable {
        depositArtist = msg.value / 2;
        depositDonee = msg.value / 2;
        assert(depositArtist+depositDonee==msg.value);
        buyer = msg.sender;
    }
    function withdrawArtist() public onlyArtist {
        assert(shipped);
        assert(received);
        artist.transfer(depositArtist);
    }
    function withdrawDonee() public onlyDonee {
        donee.transfer(depositDonee);
    }
    function withrawReturnBuyer() public onlyBuyer {
        assert(returned);
        assert(returnAccepted);
        buyer.transfer(depositArtist);
    }
    function ship() public onlyArtist {
        shipped = true;
    }
    function confirmShipmentReceived() public onlyBuyer {
        received = true;
    }
    function returnProduct() public onlyBuyer {
        returned = true;
    }
    function acceptReturn() public {
        returnAccepted = true;
    }
}