pragma solidity ^0.5.0;

import "zos-lib/contracts/Initializable.sol";

contract StableToken is Initializable {

    string public name;
    string public symbol;
    uint8 public decimals;

    address public owner;
    uint public totalSupply;
    mapping(address => uint) public balances;

    function initialize(
        address _owner,
        string memory _name,
        string memory _symbol,
        uint8 _decimals
    )
        public initializer
    {
        owner = _owner;
        name = _name;
        symbol = _symbol;
        decimals = _decimals;

        uint tokensToMint = 1000000 * (10 ** uint(decimals));
        totalSupply += tokensToMint;
        balances[owner] += tokensToMint;
    }

    //DO NOT USE THIS IN PRODUCTION
    function transfer(address _to, uint _amount) public returns (bool) {
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
    }

    //...

}
