pragma solidity ^0.4.26;

import "openzeppelin-solidity/contracts/token/ERC20/IERC20.sol";

contract LoanContract {

    enum LoanState {
        None,
        Initiated,
        Funded,
        Repayment,
        Finished
    }

    address public borrower;
    address public lender;
    IERC20 token;
    uint collateralAmount;
    uint loanAmount;
    LoanState public currentState;

    modifier onlyBorrower() {
        require(msg.sender == borrower);
        _;
    }

    modifier atState(LoanState loanState) {
        require(currentState == loanState);
        _;
    }

    modifier transitionToState(LoanState nextState) {
        _;
        currentState = nextState;
    }

    constructor(IERC20 _token, uint _collateralAmount, uint _loanAmount)
        public
        transitionToState(LoanState.Initiated)
    {
        borrower = msg.sender;
        token = _token;
        collateralAmount = _collateralAmount;
        loanAmount = _loanAmount;
    }

    function putCollateral()
        public
        onlyBorrower
        atState(LoanState.Initiated)
        transitionToState(LoanState.Funded)
    {
        require(IERC20(token)
            .transferFrom(borrower, address(this), collateralAmount));
    }
}
