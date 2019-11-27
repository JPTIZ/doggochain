pragma solidity ^0.5.2;

pragma experimental ABIEncoderV2;

import {Utils} from './utils.sol';

contract Doggo {
    enum Gender {M,F}

    struct Optional {
        Doggo get;
        bool exists;
    }

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
    Stats private _bases;

    // Effort Values. Max 255 per stat
    Stats private _evs;

    // Individual values. Differentiate stats between doggos of the same
    // species.
    Stats private _ivs;

    constructor(string memory name, string memory nickname) public {
        _nickname = nickname;
        _name = name;

        _neededExp = 100;
    }

    function initialize(
        int __hp,
        int __level,
        int __currentExp,
        int __neededExp,
        Gender __gender,
        Stats memory __bases,
        Stats memory __evs,
        Stats memory __ivs
    )
        public
        returns(Doggo)
    {
        _hp = __hp;
        _level = __level;
        _currentExp = __currentExp;
        _neededExp = __neededExp;
        _gender = __gender;
        _bases = __bases;
        _evs = __evs;
        _ivs = __ivs;

        return this;
    }

    function levelUp() internal {
        uint8 statToUpgrade = uint8(Utils.random() % 5);
        uint8 valueGrowth = uint8(Utils.random() % 3) + 1;

        if (statToUpgrade == 0) {
            _evs.attack += valueGrowth;
        } else if (statToUpgrade == 1) {
            _evs.defense += valueGrowth;
        } else if (statToUpgrade == 2) {
            _evs.spAttack += valueGrowth;
        } else if (statToUpgrade == 3) {
            _evs.spDefense += valueGrowth;
        } else if (statToUpgrade == 4) {
            _evs.speed += valueGrowth;
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
        return attrValue(_bases.attack, _evs.attack, _ivs.attack);
    }

    function defense() public view returns(int) {
        return attrValue(_bases.defense, _evs.defense, _ivs.defense);
    }

    function spAttack() public view returns(int) {
        return attrValue(_bases.spAttack, _evs.spAttack, _ivs.spAttack);
    }

    function spDefense() public view returns(int) {
        return attrValue(_bases.spDefense, _evs.spDefense, _ivs.spDefense);
    }

    function speed() public view returns(int) {
        return attrValue(_bases.speed, _evs.speed, _ivs.speed);
    }

    function bases() public view returns(Stats memory) {
        return _bases;
    }

    function evs() public view returns(Stats memory) {
        return _evs;
    }

    function ivs() public view returns(Stats memory) {
        return _ivs;
    }

    /**
     * Calculates the true value of an attribute.
     */
    function attrValue(int base, int ev, int iv) private view
        returns(int)
    {
        return 5 + (_level * (2 * base + iv + ev / 4)) / 100;
    }

    function neededExpForLevel(int __level)
        public pure
        returns(int)
    {
        int __neededExp = 100;

        for (int l = 1; l < __level; ++l) {
            uint ulevel = uint(l);
            uint level_factor = (uint(115) ** ulevel) / (uint(100) ** ulevel);

            __neededExp = __neededExp * int(level_factor);
        }

        return __neededExp;
    }
}
