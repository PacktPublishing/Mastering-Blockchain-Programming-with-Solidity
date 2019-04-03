pragma solidity >=0.5.0 <0.6.0;

import "../MSTCrowdsale.sol";

contract MSTCappedCrowdsaleMock is MSTCrowdsale {
    constructor (
        uint256 rate,
        address payable wallet,
        ERC20Mintable token,
        uint256 cap
    )
        public
        MSTCrowdsale(rate, wallet, token, now, (now + 90 days), cap)
    {

    }
}
