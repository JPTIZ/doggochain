pragma solidity ^0.5.2;

contract Doggo {
    enum Gender {M,F}

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
