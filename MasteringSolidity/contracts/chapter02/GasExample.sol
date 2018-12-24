pragma solidity 0.4.25;


contract GasExample {
    constructor () public {
        address otherContract = 0xC4FE5518f0168DA7BbafE375Cd84d30f64CDa491;
        /* gas adjustments */
        require(otherContract.call.gas(1000000)(
                "methodName", "param1"));
        require(otherContract.delegatecall.gas(1000000)(
                "methodName", "param1"));

        /* solhint-disable */
        /* Wei forwarding using value() */
        require(otherContract.call.value(1 ether)(
                "methodName", "param1"));
        //.value() not supported on delegatecall, Compilation error
        //require(otherContract.delegatecall.value(1 ether)(
        //      "methodName", "param1"));

        /* Using gas() and value() together */
        require(otherContract.call.gas(1000000).value(1 ether)(
                "methodName", "param1"));
        //This is also valid
        require(otherContract.call.value(1 ether).gas(1000000)(
                "methodName", "param1"));
        /* solhint-enable */
    }
}
