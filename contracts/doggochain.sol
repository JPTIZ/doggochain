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



    // TODO: Add `modifier`s for "sender must be <first param>". Or check how solidity deals with it.


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

    function challenge(address challenger, address target) public {
        // TODO: Implement challenging rules
    }

    function breed(Doggo _this, Doggo _with) public {
        // TODO: Implement breeding rules
    }

    function trade(address _requester, address _to, string memory _doggo_name) public {
        // TODO: Implement trading rules
    }


    /**
     * Makes _requester hunts for monsters in the wild with his given `_doggo`.
     */
    function hunt(address _requester, string memory _doggo) public {
        // TODO: Implement hunting rules
    }
}
