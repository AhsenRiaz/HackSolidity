// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.17;

contract Name {
    mapping(address => uint) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    // this function is prone to reencrancy attack.
    function withdraw(uint amount) public {
        require(balances[msg.sender] >= amount);
        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent, "Failed to send Ether");
        balances[msg.sender] -= amount;
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
