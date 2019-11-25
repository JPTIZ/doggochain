pragma solidity ^0.5.2;

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
