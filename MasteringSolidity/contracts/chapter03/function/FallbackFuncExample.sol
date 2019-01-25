pragma solidity 0.5.3;


contract FallbackFunctionExample {
    uint public weiReceived;

    function() external payable {
        weiReceived += msg.value;
    }
}
