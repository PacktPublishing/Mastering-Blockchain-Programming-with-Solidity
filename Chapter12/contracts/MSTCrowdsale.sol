pragma solidity >=0.5.0 <0.6.0;


import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "openzeppelin-solidity/contracts/crowdsale/validation/TimedCrowdsale.sol";
import "openzeppelin-solidity/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "openzeppelin-solidity/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "./MSTToken.sol";
import "openzeppelin-solidity/contracts/token/ERC20/IERC20.sol";

contract MSTCrowdsale is CappedCrowdsale, TimedCrowdsale, MintedCrowdsale {
    using SafeMath for uint256;

    constructor(
        uint256 _openingTime,
        address payable _wallet,
        IERC20 _token
    )
        Crowdsale(1000, _wallet, _token)
        TimedCrowdsale(_openingTime, _openingTime.add(90 days))
        CappedCrowdsale(10000 ether)
        public
    {

    }
}
