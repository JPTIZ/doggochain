pragma solidity ^0.5.2;

pragma experimental ABIEncoderV2;

import {Doggo} from './doggo.sol';
import {Utils} from './utils.sol';

library Breeding {
    struct Result {
        Doggo pupper;
        bool success;
    }

    function breed(Doggo _this, Doggo _with, string memory nickname)
        public
        returns (Result memory)
    {
        if (Utils.random() % 100 < 25) {
            return Result({
                pupper: new Doggo('', ''),
                success: false
            });
        }

        int result_level = (_this.level() + _with.level()) / 2;
        return Result({
            pupper: new Doggo(
                nickname,
                nickname
            ).initialize(
                (_this.maxHp() + _with.maxHp()) / 2,
                result_level,
                0,
                _this.neededExpForLevel(result_level),
                (
                    Utils.random() % 2 == 0
                        ? Doggo.Gender.M
                        : Doggo.Gender.F
                ),
                maxStats(_this.bases(), _with.bases()),
                maxStats(_this.evs(), _with.evs()),
                maxStats(_this.ivs(), _with.ivs())
            ),
            success: true
        });
    }

    function doggoValue(Doggo _doggo)
        public
        view
        returns(uint)
    {
        int statsAvg = (
            _doggo.attack() +
            _doggo.defense() +
            _doggo.spAttack() +
            _doggo.spDefense() +
            _doggo.speed()
        ) / 5;

        int hpWorth = 115 * _doggo.maxHp() / 100;

        return uint(statsAvg + hpWorth);
    }

    function maxStats(Doggo.Stats memory first, Doggo.Stats memory second)
        private pure
        returns(Doggo.Stats memory)
    {
        return Doggo.Stats({
            attack: Utils.max(first.attack, second.attack),
            defense: Utils.max(first.defense, second.defense),
            spAttack: Utils.max(first.spAttack, second.spAttack),
            spDefense: Utils.max(first.spDefense, second.spDefense),
            speed: Utils.max(first.speed, second.speed)
        });
    }
}
