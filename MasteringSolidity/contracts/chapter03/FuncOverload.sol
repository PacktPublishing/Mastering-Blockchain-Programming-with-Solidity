pragma solidity ^0.4.24;

contract FuncOverload {

    address owner;

    constructor() public {
        owner = msg.sender;
    }

    function transfer(address _to, uint _amount) public returns (bool) {
        return doTransfer(_to, _amount);
    }

    function transfer(address _to) public returns (bool) {
        return doTransfer(_to, 1 ether);
    }

    function transfer() public returns (bool) {
        return doTransfer(owner, address(this).balance);
    }

    function doTransfer(address _to, uint _amount) internal returns (bool) {
        _to.transfer(_amount);
        return true;
    }
}
