pragma solidity ^0.4.26;

contract AutoDeprecate {

    uint startTime;
    uint endTime;

    modifier whenOpen() {
        require(now > startTime && now <= endTime);
        _;
    }

    constructor(uint _startTime, uint _endTime) public {
        require(_startTime > now);
        require(_endTime > _startTime);

        startTime = _startTime;
        endTime = _endTime;
    }

    function contribute() public payable whenOpen {
        //Contribution code here
    }

    function isContributionOpen() public view returns(bool) {
        return now > startTime && now <= endTime;
    }
}


