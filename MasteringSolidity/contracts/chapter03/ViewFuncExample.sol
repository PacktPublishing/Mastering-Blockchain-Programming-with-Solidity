pragma solidity ^0.4.24;

contract ViewFuncExample {
    enum ExchangeStatus { Inactive, Active }
    ExchangeStatus status = ExchangeStatus.Active;

    function getCurrentState() public view returns (ExchangeStatus) {
        return status;
    }
    //...
}
