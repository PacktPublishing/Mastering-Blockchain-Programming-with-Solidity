pragma solidity ^0.4.24;

contract Oracle {
    struct Request {
        bytes data;
        function(uint, bytes memory) external returns (bool) callback;
    }
    modifier onlyAuthorized() {
        require(msg.sender == authorized);
        _;
    }
    address authorized = 0xefd8eD39D00D98bf43787ad0cef9afee2B5DB34F;
    Request[] requests;
    event NewRequest(uint requestID);

    function query(
        bytes data,
        function(uint, bytes memory) external returns(bool) callback
    ) public {
        //Registering callback
        requests.push(Request(data, callback));
        emit NewRequest(requests.length - 1);
    }

    function reply(uint requestID, bytes response) public onlyAuthorized {
        require(requests[requestID].callback(requestID, response));
        delete requests[requestID]; //release storage
    }
}

contract OracleUser {
    modifier onlyOracle {
        require(msg.sender == address(oracle),
            "Only oracle can call this.");
        _;
    }
    // known contract address of Oracle
    Oracle constant oracle = Oracle(0x611B947ec990Ba4e1655BF1A37586467144A2D65);
    event ResponseReceived(uint requestID, bytes response);

    function buySomething() public {
        oracle.query("USD", this.oracleResponse);
    }

    function oracleResponse(
        uint requestID,
        bytes response
    ) public onlyOracle returns (bool) {
        // Use the response data
        //...
        emit ResponseReceived(requestID, response);
        return true;
    }
}