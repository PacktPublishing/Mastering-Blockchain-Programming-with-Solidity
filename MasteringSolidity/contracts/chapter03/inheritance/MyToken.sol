pragma solidity 0.5.3;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";


contract DetailedERC20 is ERC20 {

    string public name;
    string public symbol;
    uint8 public decimals;

    constructor(string memory _name, string memory _symbol, uint8 _decimals ) public {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
    }
}


contract MyToken is DetailedERC20("MyToken", "MTKN", 18) {
    mapping(address => uint) public balances;
    //...
}


contract MyToken2 is DetailedERC20 {
    address public owner;

    constructor (
        string memory _name,
        string memory _symbol,
        uint8 _decimals
    ) public DetailedERC20(_name, _symbol, _decimals) {
        owner = msg.sender;
    }
}
