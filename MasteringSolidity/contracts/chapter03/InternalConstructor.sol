pragma solidity 0.5.3;


contract InternalConstructor {

    uint public value = 10;

    constructor () internal {
        value = 15;
    }

    function setValue(uint _value) public {
        value = _value;
    }
}
