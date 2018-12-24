pragma solidity 0.4.25;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";

contract DetailedERC20 is ERC20 {
    string public name;
    string public symbol;
    uint8 public decimals;

    constructor(string _name, string _symbol, uint8 _decimals ) public {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
    }
}

contract MyToken is DetailedERC20("MyToken", "MTKN", 18) {
}

contract MyToken2 is DetailedERC20 {
    constructor (
        string _name,
        string _symbol,
        uint8 _decimals
    ) DetailedERC20(_name, _symbol, _decimals) public {

    }
}
