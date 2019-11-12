pragma solidity ^0.5.2;

import 'remix_tests.sol';

import {DoggoChain} from './doggochain.sol';
import {DoggoList} from './doggolist.sol';

contract UsageTest {
    string constant testPlayer = "Red";

    DoggoChain private chain;

    function beforeAll() public {
        chain = new DoggoChain();
    }

    function noPlayers() public view {
        assert(chain.totalPlayers() == 0);
    }

    function onePlayerRegistered() public {
        chain.registerPlayer(testPlayer);
        assert(chain.totalPlayers() == 1);
    }

    function onePlayerEmptyDoggolist() public {
        chain.registerPlayer(testPlayer);

        (, DoggoList doggos) = chain.player(msg.sender);
        assert(doggos.isEmpty());
    }
}
