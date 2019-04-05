pragma solidity >=0.5.0 <0.6.0;


import "openzeppelin-solidity/contracts/token/ERC20/ERC20Pausable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Detailed.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Burnable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Mintable.sol";

contract MSTToken is
    ERC20Burnable, ERC20Pausable, ERC20Mintable, ERC20Detailed {

    constructor(
        string memory _name,
        string memory _symbol,
        uint8 _decimals
    )
        ERC20Detailed(_name, _symbol, _decimals)
        public
    {
        // solium-disable-previous-line no-empty-blocks
    }
}
