//Just to remove compilation warnings
pragma solidity ^0.4.24;
/*
pragma solidity ^0.5.0;

contract SpecialFunctions {

    constructor() public {

        address otherContract = 0xC4FE5518f0168DA7BbafE375Cd84d30f64CDa491;
        bytes memory payload = abi.encodeWithSignature(
            "methodName(string)",
            "stringParam");

        //Takes only bytes memory as argument
        //Returns bool success, bytes returnData
        (bool successCall, bytes memory returnDataCall)
            = address(otherContract).call(payload);
        (bool successDCall, bytes memory returnDataDcall)
            = address(otherContract).delegatecall(payload);
        (bool successSCall, bytes memory returnDataSCall)
            = address(otherContract).staticcall(payload);
    }
}
*/