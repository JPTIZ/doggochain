pragma solidity ^0.5.2;

pragma experimental ABIEncoderV2;

import {Doggo} from './doggo.sol';

library Battle {
    struct Battler {
        Doggo doggo;
        int currentHp;
    }


    struct BattleData {
        Battler challenger;
        Battler guest;
    }

    enum Result {
        Victory,
        Defeat
    }


    function simulate(Doggo challenger, Doggo guest) public view returns (Result) {
        BattleData memory data = createBattleData(challenger, guest);

        // TODO: Implement the whoooole battle simulation
        data;
    }


    function createBattleData(Doggo challenger, Doggo guest) private view returns (BattleData memory) {
        return BattleData({
            challenger: Battler({
                doggo: challenger,
                currentHp: challenger.maxHp()
            }),
            guest: Battler({
                doggo: guest,
                currentHp: guest.maxHp()
            })
        });
    }


    function isDead(Battler memory _battler) private pure returns (bool) {
        return _battler.currentHp == 0;
    }


    /**
     * Applies damage do battler *assuming damage amount was previously calculated*.
     */
    function damage(Battler memory _battler, int _amount) private pure {
        require(_amount >= 0, "Damage must be positive!");

        if (_amount > _battler.currentHp) {
            _battler.currentHp = 0;
        } else {
            _battler.currentHp -= _amount;
        }
    }


    /**
     * Heals battler *assuming heal amount was previously calculated*.
     */
    function heal(Battler memory _battler, int _amount) private view {
        require(_amount >= 0, "Heal amount must be positive!");
        require(!isDead(_battler), "Unfortunately, target is dead...");

        if (_amount > _battler.doggo.maxHp()) {
            _battler.currentHp = _battler.doggo.maxHp();
        } else {
            _battler.currentHp += _amount;
        }
    }
}
