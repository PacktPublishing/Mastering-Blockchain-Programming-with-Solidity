pragma solidity ^0.4.26;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract Mortal is Ownable {

    //...
    //Contract code here
    //...

    function kill() external onlyOwner {
        selfdestruct(owner());
    }
}
