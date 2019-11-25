pragma solidity ^0.5.2;

contract Doggo {
    enum Gender {M,F}

    struct Stats {
        int attack;
        int defense;
        int specialAttack;
        int specialDefense;
        int speed;
    }

    string internal _nickname;
    string internal _name;
    int internal _hp;
    int internal _level;

    // For breeding
    Gender internal _gender;

    // for simplicity sake, no Natures

    // Base stats. Depend on the Doggo species
    Stats private bases;

    // Effort Values. Max 255 per stat
    Stats private evs;

    // Individual values. Differentiate stats between doggos of the same
    // species.
    Stats private ivs;

    constructor(string memory name, string memory nickname) public {
        _nickname = nickname;
        _name = name;
    }

    function levelUp() internal {
        // TODO
    }

    function acquireExperience(int _amount) internal {
        // TODO
    }

    function maxHp() public view returns(int) {
        return _hp;
    }

    function level() public view returns(int) {
        return _level;
    }

    function attack() public view returns(int) {
        return _baseAttack; // TODO
    }

    function defense() public view returns(int) {
        return _baseDefense; // TODO
    }

    function spAttack() public view returns(int) {
        return _baseSpecialAttack; // TODO
    }

    function spDefense() public view returns(int) {
        return _baseSpecialDefense; // TODO
    }

    function speed() public view returns(int) {
        return _baseSpeed; // TODO
    }
}
