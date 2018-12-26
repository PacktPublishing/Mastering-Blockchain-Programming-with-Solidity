pragma solidity 0.4.25;


contract ViewFuncExample {
    enum ExchangeStatus { Inactive, Active }
    ExchangeStatus public status = ExchangeStatus.Active;

    function getCurrentState() public view returns (ExchangeStatus) {
        return status;
    }
    //...
}
