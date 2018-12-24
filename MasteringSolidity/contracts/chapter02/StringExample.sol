pragma solidity 0.4.25;

contract StringExample {
    event LOG(string s);
    function test() public {
        OtherContract oc = new OtherContract("TestString");
        internalCall(oc.getString());
    }

    function internalCall(string str) internal {
        emit LOG(str);
    }

}

contract OtherContract {
    string public str;
    constructor(string _str) public {
        str = _str;
    }
    function getString() public view returns (string) {
        return str;
    }
}
