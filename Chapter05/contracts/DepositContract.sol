pragma solidity >=0.5.3;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "openzeppelin-solidity/contracts/lifecycle/Pausable.sol";


/**
 * @title Deposit Contract to hold Ether
 */
contract DepositContract is Ownable, Pausable {
    using SafeMath for uint;

    mapping(address => uint) public balances;
    uint public totalDeposited;

    event Deposited(address indexed who, uint amount);
    event Withdrawn(address indexed who, uint amount);

    /**
     * @dev The fallback function to receive ether.
     */
    function() external payable {
        depositEther();
    }

    /**
     * @dev Deposits Ether to the contract
     */
    function depositEther() public payable whenNotPaused {
        require(msg.value > 0);
        balances[msg.sender] = balances[msg.sender].add(msg.value);
        totalDeposited = totalDeposited.add(msg.value);
        emit Deposited(msg.sender, msg.value);
    }

    /**
     * @dev Withdraw the deposit ether balance.
     * @param _amount Amount to withdraw.
     */
    function withdraw(uint _amount) public {
        require(balances[msg.sender] >= _amount);
        balances[msg.sender] = balances[msg.sender].sub(_amount);
        totalDeposited = totalDeposited.sub(_amount);
        msg.sender.transfer(_amount);
        emit Withdrawn(msg.sender, _amount);
    }
}
