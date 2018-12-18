pragma solidity ^0.4.24;

contract Ownable {
    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor() public {
        owner = msg.sender;
    }
}

contract ValueStorage is Ownable {
    uint public value = 2;

    function update() public onlyOwner {
        value += 1;
    }

    //...
}

contract ValueStorage1 is ValueStorage {

    function update() public {
        value *= 2;
        ValueStorage.update();
    }
}

contract ValueStorage2 is ValueStorage {

    function update() public {
        value *= 3;
        ValueStorage.update();
    }
}

contract InheritanceExample1 is ValueStorage1, ValueStorage2 {

}
