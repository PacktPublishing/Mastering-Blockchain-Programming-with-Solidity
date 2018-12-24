pragma solidity 0.4.25;

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

contract ModifierExample is Ownable {
    enum Status {INIT, PENDING, INPROCESS, PROCESSED}
    Status public status;

    event StatusChanged(Status status);
    modifier logAtEnd(Status _status) {
        _;
        emit StatusChanged(_status);
    }

    function changeState(Status _status) public onlyOwner logAtEnd(_status) {
        status = _status;
    }
}
