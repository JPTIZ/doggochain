pragma solidity ^0.5;

import {Doggo} from './doggo.sol';
import {DoggoList} from './doggolist.sol';

contract DoggoChain {
    struct Player {
        string name;
        DoggoList doggos;
    }

    // Because I refuse to accept the fact that mappings don't have a "hasKey"
    // method, but still don't wanna mess another type's attributes just
    // because this language doesn't have an Optional<T> type.
    struct OptionalPlayer {
        Player player;
        bool exists;
    }

    mapping (address => OptionalPlayer) players;

    function registerPlayer(address _address, string memory _name) public {
        OptionalPlayer storage player = players[_address];

        require(!player.exists, "Player already registered with this address.");

        players[_address] = OptionalPlayer({
            player: Player({
                name: _name,
                doggos: new DoggoList()
            }),
            exists: true
        });
    }
}
