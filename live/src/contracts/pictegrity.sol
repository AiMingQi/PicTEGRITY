pragma solidity ^0.5.2;

contract PicTEGRITY {
    string imageMeta;

    //Write Function
    function set(string memory _imageMeta) public {
        imageMeta = _imageMeta;
    }

    //Read Function
    function get() public view returns (string memory) {
        return imageMeta;
    }
}