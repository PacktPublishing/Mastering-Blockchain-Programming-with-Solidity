pragma solidity ^0.4.24;

contract PureFuncExample {
    function add(uint _a, uint _b) public pure returns(uint) {
        uint c = _a + _b;
        require(c >= _a);

        return c;
    }
}
