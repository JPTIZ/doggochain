pragma solidity ^0.5.2;

pragma experimental ABIEncoderV2;

import {Doggo} from './doggo.sol';
import {DoggoList} from './doggolist.sol';
import {DoggoChain} from './doggochain.sol';

contract Trade {
    enum State {
        Created,
        Canceled,
        Confirmed,
        Rejected,
        Invalidated // When doggo doesn't exist anymore
    }

    struct OptionalDoggo {
        Doggo get;
        bool exists;
    }

    struct Proposal {
        OptionalDoggo doggo;
        uint value;
    }

    Proposal offered;
    Proposal wanted;
    address payable proposer;
    address payable target;
    State public state;
    DoggoChain public chain;

    constructor(
        DoggoChain _chain,
        address payable _target,
        Proposal memory _offered,
        Proposal memory _wanted
    )
        public
    {
        require(_offered.doggo.exists || _wanted.doggo.exists);

        proposer = msg.sender;
        target = _target;
        offered = _offered;
        wanted = _wanted;
        state = State.Created;
    }

    function confirm()
        public
    {
        require(
            state == State.Created,
            'Trade current state should be "Created".'
        );

        if (offered.doggo.exists) {
            (, DoggoList proposer_doggos) = chain.player(proposer);
            if (!proposer_doggos.remove(offered.doggo.get)) {
                state = State.Invalidated;
                return;
            }
            (, DoggoList target_doggos) = chain.player(target);
            target_doggos.push(offered.doggo.get);
        }

        target.transfer(offered.value);
        proposer.transfer(wanted.value);

        state = State.Confirmed;
    }

    function reject()
        public
    {
        state = State.Rejected;

        refund();
    }

    function canceled()
        public
    {
        state = State.Canceled;

        refund();
    }

    function refund()
        public
    {
        proposer.transfer(offered.value);
    }
}
