pragma solidity 0.4.25;


contract AcceptEther {
    uint public balance;

    function deposit() public payable { //function example to accept ETH
        balance += msg.value;
    }
}
