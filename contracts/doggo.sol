pragma solidity ^0.5.2;

import {Utils} from './utils.sol';

contract Doggo {
    enum Gender {M,F}

    struct Stats {
        int attack;
        int defense;
        int spAttack;
        int spDefense;
        int speed;
    }

    string internal _nickname;
    string internal _name;
    int private _hp;
    int private _level;
    int private _currentExp;
    int private _neededExp;

    // For breeding
    Gender private _gender;

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

        _neededExp = 100;
    }

    function levelUp() internal {
        uint8 statToUpgrade = uint8(Utils.random() % 5);
        uint8 valueGrowth = uint8(Utils.random() % 3) + 1;

        if (statToUpgrade == 0) {
            evs.attack += valueGrowth;
        } else if (statToUpgrade == 1) {
            evs.defense += valueGrowth;
        } else if (statToUpgrade == 2) {
            evs.spAttack += valueGrowth;
        } else if (statToUpgrade == 3) {
            evs.spDefense += valueGrowth;
        } else if (statToUpgrade == 4) {
            evs.speed += valueGrowth;
        }

        _hp += int(Utils.random() % 5);
        ++_level;

        uint ulevel = uint(_level);
        uint level_factor = (uint(115) ** ulevel) / (uint(100) ** ulevel);

        _neededExp = _neededExp * int(level_factor);
    }

    function acquireExperience(int _amount) internal {
        _currentExp += _amount;

        while (_currentExp > _neededExp) {
            _currentExp -= _neededExp;
            levelUp();
        }
    }

    function maxHp() public view returns(int) {
        return _hp;
    }

    function level() public view returns(int) {
        return _level;
    }

    function attack() public view returns(int) {
        return attrValue(bases.attack, evs.attack, ivs.attack);
    }

    function defense() public view returns(int) {
        return attrValue(bases.defense, evs.defense, ivs.defense);
    }

    function spAttack() public view returns(int) {
        return attrValue(bases.spAttack, evs.spAttack, ivs.spAttack);
    }

    function spDefense() public view returns(int) {
        return attrValue(bases.spDefense, evs.spDefense, ivs.spDefense);
    }

    function speed() public view returns(int) {
        return attrValue(bases.speed, evs.speed, ivs.speed);
    }

    /**
     * Calculates the true value of an attribute.
     */
    function attrValue(int base, int ev, int iv) private view
        returns(int)
    {
        return 5 + (_level * (2 * base + iv + ev / 4)) / 100;
    }
}
