pragma solidity >=0.5.0 <0.6.0;

import "../MSTCrowdsale.sol";

contract MSTCrowdsaleMock {
}


contract MintedCrowdsaleImpl is MSTCrowdsale {
    constructor (uint256 rate, address payable wallet, ERC20Mintable token)
        public
        MSTCrowdsale(rate, now, wallet, token)
    {

    }
}

