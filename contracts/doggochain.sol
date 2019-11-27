pragma solidity ^0.5;

pragma experimental ABIEncoderV2;

import {Doggo} from './doggo.sol';
import {DoggoList} from './doggolist.sol';
import {Breeding} from './breed.sol';
import {Trade} from './trade.sol';

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


    function breed(Doggo _this, Doggo _with, string memory nickname)
        public
        payable
        returns(Breeding.Result memory)
    {
        // TODO: Implement breeding rules
        require(
            msg.value > Breeding.doggoValue(_this),
            "Needs more money to support the first doggo's power."
        );
        require(
            msg.value > Breeding.doggoValue(_with),
            "Needs more money to support the second doggo's power."
        );

        return Breeding.breed(_this, _with, nickname);
    }


    function trade(
        Doggo _proposed_doggo,
        address payable _to,
        Doggo _wanted_doggo,
        uint wanted_money
    )
        public
        payable
    {
        address proposer = msg.sender;

        Trade _trade = new Trade(
            this,
            _to,
            Trade.Proposal({
                doggo: Doggo.Optional({
                    get: _proposed_doggo,
                    exists: true
                }),
                value: msg.value
            }),
            Trade.Proposal({
                doggo: Doggo.Optional({
                    get: _wanted_doggo,
                    exists: true
                }),
                value: wanted_money
            })
        );
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
