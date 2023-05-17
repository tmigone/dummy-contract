// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract NotAScam {

    event Withdrawal(address indexed winner, uint256 amount, uint256 blockNumber);
    event Deposit(address indexed sender, uint256 amount, uint256 blockNumber);

    address public owner;

    constructor(address _owner) {
        owner = _owner;
    }

    // Users deposit ETH to enter the raffle
    function enterRaffle() public payable {
        require(msg.value >= 1 ether, "You need to send at least 1 ETH");
        emit Deposit(msg.sender, msg.value, block.number);
    }

    // Owner draws a "lucky" winner
    function drawWinner() public {
        require(msg.sender == owner, "Only the owner can draw a winner");

        // Randomly pick a winner
        address payable luckyWinner = payable(owner); // 👀

        // Send funds to the lucky winner
        uint256 balance = address(this).balance;
        luckyWinner.transfer(balance);
        emit Withdrawal(luckyWinner, balance, block.number);
    }
}
