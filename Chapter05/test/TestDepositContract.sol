pragma solidity >=0.5.3;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/DepositContract.sol";

contract TestDepositContract {

    // Truffle sends 3 ether to this contract for testing
    uint public initialBalance = 3 ether;

    DepositContract depositContract;

    function beforeEach() public {
        depositContract = DepositContract(DeployedAddresses.DepositContract());
    }

    function testUnpaused() public {
        Assert.equal(depositContract.paused(), false, "Contract should be UnPaused");
    }

    function testBalance() public {
        Assert.equal(address(depositContract).balance, 0, "Balance should be 0");
    }

    function testDeposit() public {
        depositContract.depositEther.value(1 ether)();

        Assert.equal(address(depositContract).balance, 1 ether, "Balance should be 1 ether");
        Assert.equal(depositContract.totalDeposited(), 1 ether, "totalDeposited should be 1 ether");
        Assert.equal(depositContract.balances(address(this)), 1 ether, "balance of this should be 1 ether");
    }
}
