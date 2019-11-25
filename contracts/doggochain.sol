pragma solidity ^0.5;

import {Doggo} from './doggo.sol';
import {DoggoList} from './doggolist.sol';
import {Breeding} from './breed.sol';

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
    int playerCount;


    // TODO: Add `modifier`s for "sender must be <first param>". Or check how solidity deals with it.

    constructor() public {
        playerCount = 0;
    }


    function registerPlayer(string memory _name) public {
        address _address = msg.sender;

        OptionalPlayer storage player = players[_address];

        require(!player.exists, "Player already registered with this address.");

        players[_address] = OptionalPlayer({
            player: Player({
                name: _name,
                doggos: new DoggoList()
            }),
            exists: true
        });

        playerCount++;
    }


    function challenge(address /* _target */) public view {
        address _challenger = msg.sender;

        _challenger;

        // TODO: Implement challenging rules
    }


    function breed(Doggo /* _this */, Doggo /* _with */) public view {
        // TODO: Implement breeding rules
    }


    function trade(address /* _to */, string memory /* _doggo_name */) public view {
        address _requester = msg.sender;

        _requester;

        // TODO: Implement trading rules
    }


    /**
     * Makes _requester hunts for monsters in the wild with his given `_doggo`.
     */
    function hunt(string memory /* _doggo */) public view {
        address _requester = msg.sender;

        _requester;

        // TODO: Implement hunting rules
    }

    function player(address _addr) public view returns (string memory, DoggoList) {
        OptionalPlayer storage opt_player = players[_addr];

        require(opt_player.exists);

        Player storage p = opt_player.player;

        return (p.name, p.doggos);
    }


    function totalPlayers() public view returns (int) {
        return playerCount;
    }
}
