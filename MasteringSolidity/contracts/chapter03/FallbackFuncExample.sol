pragma solidity ^0.4.24;

contract FallbackFunctionExample {
    uint weiReceived;

    function() external payable {
        weiReceived += msg.value;
    }
}
