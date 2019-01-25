pragma solidity 0.5.3;


contract LoanStruct {

    //Enum for LoanStatus
    enum LoanStatus { Created, Funded, Finished, Defaulted }

    //Definition of struct
    struct LoanData {
        address borrower;
        address lender;
        uint256 loanAmount;
        LoanStatus status; //LoanStatus stored.
    }
}
