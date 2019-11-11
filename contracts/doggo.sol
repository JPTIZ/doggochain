pragma solidity ^0.5;


contract DoggoChain {
    enum Gender {M,F}

    struct Doggo {
        string nickname;
        string name;
        int hp;
        int level;

        // For breeding
        Gender gender;

        // for simplicity sake, no Natures

        // Base stats. Depend on the Doggo species
        int baseAttack;
        int baseDefense;
        int baseSpecialAttack;
        int baseSpecialDefense;
        int baseSpeed;

        // Effort Values. Max 255 per stat
        int attackEv;
        int defenseEv;
        int specialAttackEv;
        int specialDefenseEv;
        int speedEv;

        // Individual values. Differentiate stats
        // between doggos of the same species.
        int attackIv;
        int defenseIv;
        int specialAttackIv;
        int specialDefenseIv;
        int speedIv;
    }

    // Because Solidity has no struct copy from memory to storage, so manual
    // array implementation is needed.
    struct DoggoList {
        mapping (uint32 => Doggo) data;
        uint32 length;
    }

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

        require(!player.exists);

        players[_address] = OptionalPlayer({
            player: Player({
                name: _name,
                doggos: DoggoList({length: 0})
            }),
            exists: true
        });
    }
}
