pragma solidity ^0.5.2;

contract Doggo {
    enum Gender {M,F}

    string public nickname;
    string public name;
    int public hp;
    int public level;

    // For breeding
    Gender public gender;

    // for simplicity sake, no Natures

    // Base stats. Depend on the Doggo species
    int public baseAttack;
    int public baseDefense;
    int public baseSpecialAttack;
    int public baseSpecialDefense;
    int public baseSpeed;

    // Effort Values. Max 255 per stat
    int public attackEv;
    int public defenseEv;
    int public specialAttackEv;
    int public specialDefenseEv;
    int public speedEv;

    // Individual values. Differentiate stats
    // between doggos of the same species.
    int public attackIv;
    int public defenseIv;
    int public specialAttackIv;
    int public specialDefenseIv;
    int public speedIv;

    constructor() public {
        // TODO
    }
}
