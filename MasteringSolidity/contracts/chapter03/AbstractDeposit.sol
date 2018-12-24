pragma solidity 0.4.25;

contract AbstractDeposit {
    function depositEther() public payable returns (bool);
}

contract DepositHolderImpl is AbstractDeposit {

    mapping(address => uint) deposits;

    function depositEther() public payable returns (bool) {
        deposits[msg.sender] += msg.value;
    }
}
