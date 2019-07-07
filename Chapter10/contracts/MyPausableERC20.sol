// NOTE: This contract will not compile with truffle compile
// This is to be used on Remix IDE
pragma solidity ^0.5.0;

import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/token/ERC20/ERC20Pausable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/token/ERC20/ERC20Detailed.sol";

contract MyPausableERC20 is ERC20Pausable, ERC20Detailed {

    constructor() public ERC20Detailed("My Token", "SYM", 18) {
        //Mints 1 million token
        _mint(msg.sender, 1000000 * (10 ** 18));
    }
}