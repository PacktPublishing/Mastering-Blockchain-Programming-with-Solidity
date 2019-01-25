pragma solidity 0.5.3;


contract FuncOverload {

    address public owner;

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
