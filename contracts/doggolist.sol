pragma solidity ^0.5.2;

import {Doggo} from './doggo.sol';

// Because Solidity has no struct copy from memory to storage, so manual
// array implementation is needed.
contract DoggoList {
    mapping (uint32 => Doggo) private data;
    uint32 private _length;

    constructor() public {
        _length = 0;
    }

    function push(Doggo _doggo) public {
        data[_length] = _doggo;
        _length += 1;
    }

    function pop() public returns (Doggo){
        _length -= 1;
        return data[_length + 1];
    }

    function at(uint32 index) public view returns(Doggo) {
        require(index < _length, 'Index must be in list bounds.');

        return data[index];
    }

    function length() public view returns(uint32) {
        return _length;
    }

    function isEmpty() public view returns (bool) {
        return _length == 0;
    }
}
