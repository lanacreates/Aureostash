// contracts/AureoStashStorage.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./interfaces/IAureoStash.sol";

contract AureoStashStorage {
    mapping(address => uint256[]) public userGoals;
    mapping(uint256 => IAureoStash.SavingsGoal) public goals;
    uint256 public nextGoalId;

    // Events
    event GoalUpdated(uint256 indexed goalId);
}