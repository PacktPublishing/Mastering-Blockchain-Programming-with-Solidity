pragma solidity 0.5.3;

//pragma solidity ^0.5.0;

contract SpecialFunctions {

    constructor() public {

        address otherContract = 0xC4FE5518f0168DA7BbafE375Cd84d30f64CDa491;
        bytes memory payload = abi.encodeWithSignature(
            "methodName(string)",
            "stringParam");

        //Takes only bytes memory as argument
        //Returns bool success, bytes returnData
        //works with Solidity 0.5.0
        (bool successCall, bytes memory returnDataCall)
            = address(otherContract).call(payload);
        require(successCall);

        (bool successDCall, bytes memory returnDataDcall)
            = address(otherContract).delegatecall(payload);
         require(successDCall);

        (bool successSCall, bytes memory returnDataSCall)
            = address(otherContract).staticcall(payload);
        require(successSCall);


        //Solidity 0.4.25
        /* solhint-disable */
        /* solium-disable */
        /*
        require(address(otherContract).call(payload));

        require(address(otherContract).delegatecall(payload));
        */
        /* solium-enable */
        /* solhint-enable */
    }
}
