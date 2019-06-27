pragma solidity ^0.4.26;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";

contract Subscription is Ownable {

    using SafeMath for uint;

    mapping(address => uint) public subscribed;
    address[] public subscriptions;

    uint subscriptionFeePerDay = 1 ether;

    event Subscribed(
        address indexed subscriber,
        uint subscriptionFee,
        uint subscriptionPeriodDays);

    modifier whenExpired() {
        require(isSubscriptionExpired(msg.sender));
        _;
    }

    modifier whenNotExpired() {
        require( ! isSubscriptionExpired(msg.sender));
        _;
    }

    constructor(uint _subscriptionFeePerDay) public {
        subscriptionFeePerDay = _subscriptionFeePerDay;
    }

    function isSubscriptionExpired(address _addr) public view returns (bool) {
        uint expireTime = subscribed[_addr];
        return expireTime == 0 || now > expireTime;
    }

    function subscribe(uint _days) public payable whenExpired {
        require(_days > 0);
        require(msg.value == subscriptionFeePerDay.mul(_days));
        subscribed[msg.sender] = now.add((_days.mul(1 days)));
        subscriptions.push(msg.sender);
        emit Subscribed(msg.sender, msg.value, _days);
    }

    function withdraw() public onlyOwner {
        owner().transfer(address(this).balance);
    }

    function updateSubscriptionFee(uint _subscriptionFeePerDay) public onlyOwner {
        require(_subscriptionFeePerDay > 0);
        subscriptionFeePerDay = _subscriptionFeePerDay;
    }

    function useService() public whenNotExpired {
        //User allowed to use service
    }
}
