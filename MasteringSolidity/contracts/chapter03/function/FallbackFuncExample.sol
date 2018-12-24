pragma solidity 0.4.25;

contract FallbackFunctionExample {
    uint weiReceived;

    function() external payable {
        weiReceived += msg.value;
    }
}
