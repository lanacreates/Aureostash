// contracts/interfaces/IAureoStash.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface IAureoStash {
    struct SavingsGoal {
        string title;
        uint256 targetAmount;
        uint256 currentAmount;
        uint256 startTime;
        uint256 endTime;
        bool isStaked;
        address token;
        bool completed;
    }

    event GoalCreated(
        uint256 indexed goalId,
        address indexed user,
        string title,
        uint256 targetAmount
    );
    event Deposited(
        uint256 indexed goalId,
        address indexed user,
        uint256 amount
    );
    event Withdrawn(
        uint256 indexed goalId,
        address indexed user,
        uint256 amount,
        bool withPenalty
    );
    event StakingToggled(uint256 indexed goalId, bool isStaked);
}