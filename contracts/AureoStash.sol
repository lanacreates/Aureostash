// contracts/AureoStash.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./interfaces/IAureoStash.sol";
import "./AureoStashStorage.sol";
import "./StakingManager.sol";

contract AureoStash is IAureoStash, AureoStashStorage, ReentrancyGuard, Ownable {
    uint256 public constant EARLY_WITHDRAWAL_PENALTY = 200; // 2% in basis points
    StakingManager public stakingManager;
    
    constructor(address _stakingManager) Ownable(msg.sender) {
        stakingManager = StakingManager(_stakingManager);
    }
    
    modifier onlyGoalOwner(uint256 goalId) {
        require(isGoalOwner(msg.sender, goalId), "Not goal owner");
        _;
    }
    
    function createSavingsGoal(
        string memory title,
        uint256 targetAmount,
        uint256 duration,
        address token
    ) external nonReentrant returns (uint256) {
        require(targetAmount > 0, "Target amount must be positive");
        require(duration > 0, "Duration must be positive");
        
        uint256 goalId = nextGoalId++;
        goals[goalId] = SavingsGoal({
            title: title,
            targetAmount: targetAmount,
            currentAmount: 0,
            startTime: block.timestamp,
            endTime: block.timestamp + duration,
            isStaked: false,
            token: token,
            completed: false
        });
        
        userGoals[msg.sender].push(goalId);
        
        emit GoalCreated(goalId, msg.sender, title, targetAmount);
        return goalId;
    }
    
    function deposit(uint256 goalId, uint256 amount) external nonReentrant onlyGoalOwner(goalId) {
        SavingsGoal storage goal = goals[goalId];
        require(!goal.completed, "Goal already completed");
        require(amount > 0, "Amount must be positive");
        
        IERC20(goal.token).transferFrom(msg.sender, address(this), amount);
        
        goal.currentAmount += amount;
        
        if (goal.isStaked) {
            IERC20(goal.token).approve(address(stakingManager), amount);
            stakingManager.stake(goalId, amount);
        }
        
        emit Deposited(goalId, msg.sender, amount);
        
        if (goal.currentAmount >= goal.targetAmount) {
            goal.completed = true;
        }
    }
    
    function withdraw(uint256 goalId) external nonReentrant onlyGoalOwner(goalId) {
        SavingsGoal storage goal = goals[goalId];
        require(goal.currentAmount > 0, "No funds to withdraw");
        
        uint256 amount = goal.currentAmount;
        uint256 penalty = 0;
        
        if (!goal.completed && block.timestamp < goal.endTime) {
            penalty = (amount * EARLY_WITHDRAWAL_PENALTY) / 10000;
            amount -= penalty;
        }
        
        uint256 rewards = 0;
        if (goal.isStaked) {
            (uint256 stakedAmount, uint256 stakingRewards) = stakingManager.unstake(goalId);
            rewards = stakingRewards;
        }
        
        goal.currentAmount = 0;
        goal.isStaked = false;
        
        IERC20(goal.token).transfer(msg.sender, amount + rewards);
        if (penalty > 0) {
            IERC20(goal.token).transfer(owner(), penalty);
        }
        
        emit Withdrawn(goalId, msg.sender, amount + rewards, penalty > 0);
    }
    
    function toggleStaking(uint256 goalId) external nonReentrant onlyGoalOwner(goalId) {
        SavingsGoal storage goal = goals[goalId];
        require(!goal.completed, "Goal already completed");
        
        if (!goal.isStaked && goal.currentAmount > 0) {
            IERC20(goal.token).approve(address(stakingManager), goal.currentAmount);
            stakingManager.stake(goalId, goal.currentAmount);
        } else if (goal.isStaked) {
            stakingManager.unstake(goalId);
        }
        
        goal.isStaked = !goal.isStaked;
        emit StakingToggled(goalId, goal.isStaked);
    }
    
    function isGoalOwner(address user, uint256 goalId) public view returns (bool) {
        uint256[] memory userGoalIds = userGoals[user];
        for (uint256 i = 0; i < userGoalIds.length; i++) {
            if (userGoalIds[i] == goalId) {
                return true;
            }
        }
        return false;
    }
    
    function getUserGoals(address user) external view returns (uint256[] memory) {
        return userGoals[user];
    }
    
    function getGoalDetails(uint256 goalId) external view returns (SavingsGoal memory) {
        return goals[goalId];
    }
}