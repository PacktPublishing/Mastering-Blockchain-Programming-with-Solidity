pragma solidity 0.5.3;

import "./ControlledAddressList.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";


contract TokenList is Ownable {

    using ControlledAddressList for ControlledAddressList.Data;
    ControlledAddressList.Data private data;

    function add(address _token) public onlyOwner returns (bool) {
        return data.enable(_token);
    }

    function remove(address _token) public onlyOwner returns (bool) {
        return data.disable(_token);
    }

    function isPresent(address _token) public view returns (bool) {
        return data.isEnabled(_token);
    }
}
