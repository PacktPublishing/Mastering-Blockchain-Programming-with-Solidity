pragma solidity 0.4.25;

contract ConstantExample {
    string public constant symbol = "TKN";
    uint public constant totalSupply = 10 ** 9;
    bytes32 public constant hash = keccak256(abi.encodePacked(symbol));
}