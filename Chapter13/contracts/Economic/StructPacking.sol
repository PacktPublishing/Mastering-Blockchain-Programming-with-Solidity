pragma solidity ^0.4.26;

contract StructPacking {

    struct Record {
        uint param1;
        uint param2;

        bool valid1;
        bool valid2;
    }

    Record[] records;

    //Params can be passed to function
    function addRecord() public {
        Record memory record = Record(
            1, 2, true, true);

        records.push(record);
    }
}