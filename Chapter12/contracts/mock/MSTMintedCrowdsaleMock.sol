pragma solidity >=0.5.0 <0.6.0;

import "../MSTCrowdsale.sol";

contract MSTMintedCrowdsaleMock is MSTCrowdsale {
    constructor (
        uint256 rate,
        address payable wallet,
        ERC20Mintable token
    )
        public
        MSTCrowdsale(rate, wallet, token, now, (now + 90 days), 10000 ether)
    {

    }
}

