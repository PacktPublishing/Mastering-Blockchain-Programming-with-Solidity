pragma solidity ^0.4.26;

contract AccessControl {

    address public owner;
    address public admin;

    bool public paused;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin);
        _;
    }

    modifier onlyAuthorized() {
        require(msg.sender == owner || msg.sender == admin);
        _;
    }

    function changeAdmin(address _newAdmin) public onlyOwner {
        require(_newAdmin != address(0));
        admin = _newAdmin;
    }

    function pause() public onlyAuthorized {
        require(paused == false);
        paused = true;
    }
}
