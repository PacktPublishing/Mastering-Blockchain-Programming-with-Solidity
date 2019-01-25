pragma solidity 0.5.3;


contract AcceptEtherWithLog {

    /*
     * Event declaration
     * @param _who Address of the account who deposited ETH.
     *        Parameter indexed, to allow it to filter events on client side.
     * @param _amount Amount of Wei deposited to contract.
     */
    event Deposited(address indexed _who, uint256 _amount);

    function deposit() public payable { //function example to accept ETH
        //...

        //Emits the Deposited event in Logs of transaction data
        emit Deposited(msg.sender, msg.value);
    }
}
