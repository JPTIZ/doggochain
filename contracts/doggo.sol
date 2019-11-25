pragma solidity ^0.5.2;

contract Doggo {
    enum Gender {M,F}

    string internal _nickname;
    string internal _name;
    int internal _hp;
    int internal _level;

    // For breeding
    Gender internal _gender;

    // for simplicity sake, no Natures

    // Base stats. Depend on the Doggo species
    int private _baseAttack;
    int private _baseDefense;
    int private _baseSpecialAttack;
    int private _baseSpecialDefense;
    int private _baseSpeed;

    // Effort Values. Max 255 per stat
    int private _attackEv;
    int private _defenseEv;
    int private _specialAttackEv;
    int private _specialDefenseEv;
    int private _speedEv;

    // Individual values. Differentiate stats between doggos of the same
    // species.
    int private _attackIv;
    int private _defenseIv;
    int private _specialAttackIv;
    int private _specialDefenseIv;
    int private _speedIv;

    constructor() public {
        // TODO
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
