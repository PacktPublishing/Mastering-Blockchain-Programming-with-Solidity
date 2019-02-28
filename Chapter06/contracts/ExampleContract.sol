pragma solidity ^0.5.3;

/**
 * WARNING: This contract is only for linters to show warning messages.
 * This contract should not be as a reference for contract development.
 */
contract ExampleContract {
    mapping(address => uint) deposited;

    event Deposit(address from, uint amount);

    function() external payable {
        //require without error message, however its optional
        require(msg.value > 1 ether);

        //Unused hash variable
        bytes32 hash = blockhash(block.number - 1);

        deposited[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function deposit() public payable {
        deposited[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw() public {
        uint balance = deposited[msg.sender];
        require(balance > 0);
        deposited[msg.sender] -= balance;
        //Using send here. It should not be used
        (bool result) = msg.sender.send(balance);
        require(result);
    }

    //assigning to function argument
    function test(uint a, uint b) public pure returns(uint c) {
        a = a * b;
        c = a;
    }

}
