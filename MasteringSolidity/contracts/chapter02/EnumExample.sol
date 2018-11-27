pragma solidity ^0.4.24;


contract EnumExample {

    //Enum for LoanStatus
    enum LoanStatus {Created, Funded, Finished, Defaulted}

    LoanStatus status = LoanStatus.Funded;

    //To get the current LoanStatus
    function getStatus() public returns (LoanStatus) {
        return status;
    }

    //Is loan finished
    function isFinished() public returns (bool) {
        return status == LoanStatus.Finished;
    }
}
