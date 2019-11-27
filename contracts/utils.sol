pragma solidity ^0.5.2;

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

    function max(uint a, uint b) public pure returns(uint) {
        return a > b ? a : b;
    }

    function max(int a, int b) public pure returns(int) {
        return a > b ? a : b;
    }
}
