pragma solidity 0.4.25;


contract SelectorExample {
    //Returns first 4 bytes of method signature 0x2c383a9f
    function method() public pure returns (bytes4) {
        return this.method.selector;
    }
}