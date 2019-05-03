pragma solidity ^0.5.2;


contract RockPaperScissor
{

    enum Choice {NONE, ROCK, PAPER, SCISSOR}

    struct PlayerChoice {
        address player;
        bytes32 commitHash;
        Choice choice;
    }

    PlayerChoice[2] players;

    function registerPlayer() public {
        if(players[0].player == address(0))
            players[0].player = msg.sender;

        if(players[1].player == address(0))
            players[1].player = msg.sender;

        revert("All players registered");
    }

    function play(bytes32 _commitHash) public {
        uint index = validateAndFindPlayerIndex();
        players[index].commitHash = _commitHash;
    }

    function reveal(Choice _choice, bytes32 _salt) public {
        require(
            players[0].commitHash != 0x0 &&
            players[1].commitHash != 0x0
        );
        uint index = findPlayerIndex();
        require(players[index].commitHash == getSaltedHash(_choice,_salt));
        players[index].choice = _choice;
    }

    function getSaltedHash(Choice _answer, bytes32 _salt)
        internal view returns (bytes32) {
        return keccak256(abi.encodePacked(address(this), _answer, _salt));
    }

    function checkWinner() public {
        require(
            players[0].choice != Choice.NONE &&
            players[1].choice != Choice.NONE
        );
        //Code to check winner and reward
    }

    function validateAndFindPlayerIndex() internal returns (uint) {
        if(
            players[0].player == msg.sender &&
            players[0].commitHash == 0x0
        ) return 0;

        if(
            players[1].player == msg.sender &&
            players[1].commitHash == 0x0
        ) return 1;

        revert("Invalid call");
    }

    function findPlayerIndex() internal returns(uint) {
        if(players[0].player == msg.sender) return 0;
        if(players[1].player == msg.sender) return 1;

        revert("Invalid sender");
    }
}