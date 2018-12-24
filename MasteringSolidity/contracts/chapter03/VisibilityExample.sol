pragma solidity 0.4.25;


contract SuperContract {
    uint internal data;

    function externalFn() external returns (uint) { data = 99; }
    function publicFn() public returns (uint) { data = 100; }
    function setData(uint _a) internal { data = _a; }
    function multiply(uint _a) private pure returns (uint) { return _a * 2; }
}


contract VisibilityExample is SuperContract {
    function readData() public {
        //Following calls: error: not accessible
        //uint result = multiply(2);
        //externalFn();

        //Following calls: Allowed access
        data = data * 5; //variable accessible
        setData(10); //function accessible
        this.externalFn();
        publicFn();
    }
}


//Contract accessing VisibilityExample contract
contract ExternalContract {
    VisibilityExample public ve = VisibilityExample(0x1);

    function accessOtherContract() public {
        //Following calls: error: not accessible
        //ve.setData(10);
        //ve.multiply(10);

        //Following calls: Allowed access
        ve.externalFn();
        ve.publicFn();
        ve.readData();
    }
}
