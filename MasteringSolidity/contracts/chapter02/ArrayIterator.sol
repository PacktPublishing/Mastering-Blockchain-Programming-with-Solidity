pragma solidity ^0.4.24;

library ArrayIteratorLib {

    function iterate(function(uint) pure returns (uint) _skipFn) internal pure returns (uint[] tempArr){
        tempArr = new uint[](10);
        for(uint i = 0; i < 10 ; i++) {
            tempArr[i] = _skipFn(i + 1);
        }
    }
}

contract SkipContract {
    function skip1(uint _i) internal pure returns(uint) {
        return _i * 1;
    }

    function skip2(uint _i) internal pure returns(uint) {
        return _i * 2;
    }

    //Returns Array[1,2,3,4,5,6,7,8,9,10]
    function getFirst10WithSkip1() public pure returns (uint[]){
        return ArrayIteratorLib.iterate(skip1);
    }

    //Returns Array[2,4,6,8,10,12,14,16,18,20]
    function getFirst10WithSkip2() public pure returns (uint[]){
        return ArrayIteratorLib.iterate(skip2);
    }

}

