pragma solidity ^0.5;

library Utils {
    function seed() private pure returns(uint256) {
        // Mocked seed
        // Value obtained by throwing a 10^8 side dice, so it is guaranteed to
        // be random.
        return 26112019;
    }

    function random() public view returns(uint256) {
        return uint256(keccak256(abi.encode(
            uint256(msg.sender) * block.timestamp * seed() *
            uint256(blockhash(block.number - 1))
        )));
    }
}
