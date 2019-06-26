pragma solidity ^0.5.0;


contract Example{
    uint256 seed;
    address winner;
    mapping(address => uint256) balances;
    address[] investors;
    uint256 numInvestors;
    address owner;

    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function sell() public {
        uint amount = balances[msg.sender];
        msg.sender.call.value(amount)("");
        balances[msg.sender] = 0;
    }

    function random() public returns (uint256) {
        seed = uint256(keccak256(abi.encodePacked(blockhash(block.number), seed, tx.gasprice, now)));
        return seed;
    }

    function selectWinner() onlyOwner public {
        require(tx.origin == owner);
        winner = investors[random() % numInvestors];
    }

    function kill(address payable to) public {
        selfdestruct(to);
    }

}