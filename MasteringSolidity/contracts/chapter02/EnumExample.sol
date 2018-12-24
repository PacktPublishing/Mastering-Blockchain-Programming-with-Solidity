pragma solidity 0.4.25;


contract EnumExample {

    //Enum for LoanStatus
    enum LoanStatus {Created, Funded, Finished, Defaulted}

    LoanStatus public status = LoanStatus.Funded;

    //To get the current LoanStatus
    function getStatus() public view returns (LoanStatus) {
        return status;
    }

    //Is loan finished
    function isFinished() public view returns (bool) {
        return status == LoanStatus.Finished;
    }
}
