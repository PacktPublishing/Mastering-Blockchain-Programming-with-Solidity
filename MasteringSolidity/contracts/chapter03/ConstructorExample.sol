pragma solidity 0.4.25;


contract ConstructorExample {

    string public tokenName;
    string public symbol;
    address public owner;

    constructor(string _tokenName, string _symbol) public {
        owner = msg.sender;
        tokenName = _tokenName;
        symbol = _symbol;
    }
    //...
}


contract NoConstructor {
    string public tokenName = "Sample Token";
    string public symbol = "SYMB";
    address public owner = msg.sender;
}
