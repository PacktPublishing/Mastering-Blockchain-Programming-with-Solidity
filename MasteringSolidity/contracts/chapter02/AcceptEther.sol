pragma solidity 0.5.3;


contract AcceptEther {
    uint public balance;

    function deposit() public payable { //function example to accept ETH
        balance += msg.value;
    }
}
