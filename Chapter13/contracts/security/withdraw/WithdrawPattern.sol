pragma solidity ^0.4.26;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract DividendContract is Ownable {

    address[] public investors;
    mapping(address => uint) balances;

    function registerInvestor(address _investor) public onlyOwner {
        require(_investor != address(0));
        investors.push(_investor);
    }

    //Bad Practice
    function distributeDividend() public onlyOwner {
        for(uint i = 0; i < investors.length; i++) {
            uint amount = calculateDividend(investors[i]);
            investors[i].transfer(amount);
        }
    }

    function withdrawDividend() public {
        uint amount = balances[msg.sender];
        require(amount > 0);
        balances[msg.sender] = 0;
        msg.sender.transfer(amount);
    }


    function calculateDividend(address _investor) internal returns(uint) {
        //Dividend calculation here
    }
}
