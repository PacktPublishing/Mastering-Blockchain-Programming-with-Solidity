pragma solidity >=0.5.0 <0.6.0;


import "openzeppelin-solidity/contracts/crowdsale/validation/TimedCrowdsale.sol";
import "openzeppelin-solidity/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "openzeppelin-solidity/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "openzeppelin-solidity/contracts/token/ERC20/IERC20.sol";

/**
 * @title Mastering Solidity Token Crowdsale contract.
 * @dev Contract accept ETH and mint new MSTToken for the ETH sender.
 * The Crowdsale has some features:
 * CappedCrowdsale: Max ETH cap the Crowdsale accept.
 * TimedCrowdsale: Crowdsale starts on openingTime and closes on closingTime.
 * MintedCrowdsale: The Crowdsale mints new token via the MSTToken contract.
 */
contract MSTCrowdsale is
    CappedCrowdsale, TimedCrowdsale, MintedCrowdsale {

    /**
     * @dev Contract constructor accepts parameter and initialize the crowdsale.
     * @param _rate Rate for the Crowdsale contract.
     * @param _wallet Wallet address where ETH will be sent.
     * @param _token MSTToken address.
     * @param _openingTime Opening time of the Crowdsale.
     * @param _closingTime Closing time of the Crowdsale.
     * @param _cap Max cap in ETH for Crowdsale.
     */
    constructor(
        uint256 _rate,
        address payable _wallet,
        IERC20 _token,
        uint256 _openingTime,
        uint256 _closingTime,
        uint256 _cap
    )
        Crowdsale(_rate, _wallet, _token)
        TimedCrowdsale(_openingTime, _closingTime)
        CappedCrowdsale(_cap)
        public
    {
        // solium-disable-previous-line no-empty-blocks
    }
}
