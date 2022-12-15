// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.17;
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract Name is ReentrancyGuard {
    mapping(address => uint) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    // Always use CEI Pattern (Check Effect Interact)
    // Use Openzeppelin ReentrencyGuard Mutex
    // It puts a lock on the contract state
    function withdraw(uint amount) public nonReentrant {
        require(balances[msg.sender] >= amount);
        balances[msg.sender] -= amount;
        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent, "Failed to send Ether");
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
