pragma solidity ^0.4.24;

contract ArraysExample {
    //Dynamic Array
    address[] public owners;
    constructor(address[] _owners) public {
        for(uint i = 0; i < _owners.length ; i++) {
            uint newLength = owners.push(_owners[i]);
        }
    }

    function removeLast() public {
        //Check to ensure that array has element
        //Without this check, .length will have integer underflow.
        require(owners.length > 0);

        //Removes the last element from dynamic array
        owners.length--;
    }
}
