pragma solidity ^0.5;


contract DoggoChain {
    struct Doggo {
        string name;
        int hp;
        int strength;
        int magic;
        int vitality;
        int agility;
        int luck;
    }

    struct Player {
        string name;
        Doggo[] doggos;
    }

    // Because I refuse to accept the fact that mappings don't have a "hasKey"
    // method, but still don't wanna mess another type's attributes just
    // because this language doesn't have an Optional<T> type.
    struct OptionalPlayer {
        Player player;
        bool exists;
    }

    mapping (address => OptionalPlayer) public players;

    function registerPlayer(address _address, string memory _name) public {
        OptionalPlayer storage player = players[_address];

        require(!player.exists);

        players[_address] = OptionalPlayer({
            player: Player({
                name: _name,
                doggos: new Doggo[]
            }),
            exists: true
        });
    }
}
