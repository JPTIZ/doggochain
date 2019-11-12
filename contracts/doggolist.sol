pragma solidity ^0.5.2;

import {Doggo} from './doggo.sol';

// Because Solidity has no struct copy from memory to storage, so manual
// array implementation is needed.
contract DoggoList {
    mapping (uint32 => Doggo) data;
    uint32 length;

    function push(Doggo _doggo) public {
        data[length] = _doggo;
        length += 1;
    }

    function isEmpty() public view returns (bool) {
        return length == 0;
    }

    constructor() public {
        length = 0;
    }
}
