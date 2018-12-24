pragma solidity 0.4.25;

contract PureFuncExample {
    function add(uint _a, uint _b) public pure returns(uint) {
        uint c = _a + _b;
        require(c >= _a);

        return c;
    }
}
