pragma solidity 0.4.25;

import "openzeppelin-solidity/contracts/token/ERC20/BasicToken.sol";
import "openzeppelin-solidity/contracts/lifecycle/Pausable.sol";


contract FuncOverride is BasicToken, Pausable {

    //Overriding transfer function of BasicToken.sol
    function transfer(address to, uint256 value)
        public
        whenNotPaused
        returns (bool)
    {
        return super.transfer(to, value);
    }
}