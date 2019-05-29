pragma solidity ^0.4.26;

contract StringComparision {

    function compare(string memory a, string memory b) internal returns (bool) {
        if(bytes(a).length != bytes(b).length) {
            return false;
        } else {
            return keccak256(a) == keccak256(b);
        }
    }
}
