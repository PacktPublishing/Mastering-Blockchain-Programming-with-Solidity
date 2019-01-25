pragma solidity 0.5.3;


contract EventExample {
    uint public balance;
    event Deposited(address indexed from, uint amount);

    function () external payable {
        balance += msg.value;
        emit Deposited(msg.sender, msg.value);
    }
}
