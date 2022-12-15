// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Lib {
    address public owner;

    function pwn() public {
        owner = msg.sender;
    }
}

contract HackMe {
    address public owner;
    Lib public lib;

    constructor(Lib _lib) {
        owner = msg.sender;
        lib = Lib(_lib);
    }

    // bad use of delegate
    // use of delegate inside contract
    fallback() external payable {
        address(lib).delegatecall(msg.data);
    }
}

// Prevention: Use Stateless Library
