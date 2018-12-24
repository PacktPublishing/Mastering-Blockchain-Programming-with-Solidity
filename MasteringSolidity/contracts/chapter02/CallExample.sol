pragma solidity 0.4.25;


contract CallExample {
    constructor() public {
        address otherContract = 0xC4FE5518f0168DA7BbafE375Cd84d30f64CDa491;
        string memory param1 = "param1-string";
        uint param2 = 10;

        /* solhint-disable */
        /* solium-disable */
        //With multiple parameters
        require(otherContract.call("methodName", param1, param2));
        require(otherContract.delegatecall("methodName", param1, param2));

        //With signatures
        require(
            otherContract.call(bytes4(keccak256("methodName(string,uint256)")),
            param1,
            param2)
        );
        require(
            otherContract.delegatecall(bytes4
            (
                keccak256("methodName(string,uint256)")), param1, param2
            )
        );
        /* solhint-enable */
    }
}
