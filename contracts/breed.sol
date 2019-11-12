pragma solidity ^0.5.2;

pragma experimental ABIEncoderV2;

import {Doggo} from './doggo.sol';

library Breeding {
    struct Result {
        Doggo pupper;
        bool success;
    }

    function breed(Doggo _this, Doggo _with) public returns (Result memory) {
        _this; // TODO: Remove after usage
        _with; // TODO: Remove after usage

        // TODO: Implement breeding process

        return Result({pupper: new Doggo(), success: false});
    }
}
