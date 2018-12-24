pragma solidity 0.4.25;


contract ChildContract {
    uint public id;
    uint public balance;

    constructor(uint _id) public payable {
        id = _id;
        balance = msg.value;
    }
}


contract MainContract {
    ChildContract[] public register;

    //ChildContract will be created when MainContract is deployed
    ChildContract public childContract = new ChildContract(100);

    constructor() public {
        register.push(childContract);
    }

    function createChildContract(uint _id) public returns(address) {
        ChildContract newChild = new ChildContract(_id);
        register.push(newChild);
        return newChild;
    }

    //Send ether along with the ChildContract creation
    function createChildAndPay(uint _id, uint _amount)
        public
        payable
        returns(address)
    {
        require(msg.value == _amount);
        ChildContract newChild = (new ChildContract).value(_amount)(_id);
        register.push(newChild);
        return newChild;
    }
}