pragma solidity ^0.4.26;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract DepositContract is Ownable {

    mapping(address => uint) public balances;
    address[] public holders;

    function deposit() public payable {
        require(msg.value > 0);
        bool exists = balances[msg.sender] != 0;
        if (!exists) {
            holders.push(msg.sender);
        }
        balances[msg.sender] += msg.value;
    }

    function getHoldersCount() public view returns (uint) {
        return holders.length;
    }

}