pragma solidity >=0.5.0 <0.6.0;


import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "openzeppelin-solidity/contracts/crowdsale/validation/TimedCrowdsale.sol";
import "openzeppelin-solidity/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "./MSTToken.sol";

contract MSTCrowdsale is TimedCrowdsale, MintedCrowdsale {
    using SafeMath for uint256;

    constructor(
        uint256 _openingTime,
        address payable _wallet,
        MSTToken _token
    )
        TimedCrowdsale(_openingTime, _openingTime.add(90 days))
        Crowdsale(1000, _wallet, _token)
        public
    {

    }
}
