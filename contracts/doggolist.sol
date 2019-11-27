pragma solidity ^0.5.2;

import {Doggo} from './doggo.sol';

// Because Solidity has no struct copy from memory to storage, so manual
// dynamic array implementation is needed.
contract DoggoList {
    mapping (int => Doggo) private data;
    int private _length;

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

    function remove(int index) public returns (Doggo) {
        Doggo doggo = at(index);
        --_length;
        for (int i = index; i < _length; ++i) {
            data[i] = data[i + 1];
        }
        return doggo;
    }

    function at(int index) public view returns(Doggo) {
        require(index >= 0 && index < _length, 'Index must be in list bounds.');

        return data[index];
    }

    function length() public view returns(int) {
        return _length;
    }

    function isEmpty() public view returns (bool) {
        return _length == 0;
    }
}
