pragma solidity ^0.5.0;

import "zos-lib/contracts/Initializable.sol";

contract StableToken is Initializable {

    string public name;
    string public symbol;
    uint8 public decimals;

    address public owner;
    uint public totalSupply;
    mapping(address => uint) public balances;

    //Introduced in version v2
    address public admin;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    modifier onlyAdmin() {
        require(msg.sender == admin);
        _;
    }

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

    //Fixed integer overflow issue in v2
    function transfer(address _to, uint _amount) public returns (bool) {
        require(balances[msg.sender] >= _amount);
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;

        emit Transfer(msg.sender, _to, _amount);
        return true;
    }

    function initializeAdmin(address _admin) public {
        require(admin == address(0));
        admin = _admin;
    }

    function mint(uint _newTokens) public onlyAdmin {
        uint tempTotalSupply = totalSupply + _newTokens;
        require(tempTotalSupply >= totalSupply);

        totalSupply += _newTokens;
        balances[admin] += _newTokens;
    }

    //Rest of the code
}
