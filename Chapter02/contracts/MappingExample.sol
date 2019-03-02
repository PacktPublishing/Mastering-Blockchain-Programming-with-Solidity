pragma solidity 0.5.3;


contract MappingExample {
    mapping(address => uint) public balances;

    function update(uint newBalance) public {
        //Adds a new mapping if not present.
        //Updates the new value if entry already present.
        balances[msg.sender] = newBalance;
    }

    //Increases balance by _increaseBy numbers
    function increaseBalance(uint _increaseBy) public {
        update(balanceOf(msg.sender) + _increaseBy);
    }

    function balanceOf(address _user) public view returns (uint) {
        //Gets the entry from mapping
        return balances[_user];
    }
}

