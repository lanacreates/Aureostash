// contracts/StakingManager.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract StakingManager is ReentrancyGuard, Ownable {
    mapping(uint256 => uint256) public stakedBalances;
    mapping(uint256 => uint256) public stakingStartTime;
    mapping(address => uint256) public rewardRates; // Rewards per token per second

    event Staked(uint256 indexed goalId, uint256 amount);
    event Unstaked(uint256 indexed goalId, uint256 amount, uint256 rewards);
    
    constructor() Ownable(msg.sender) {}

    function stake(uint256 goalId, uint256 amount) external nonReentrant {
        require(amount > 0, "Cannot stake 0");
        
        stakedBalances[goalId] += amount;
        stakingStartTime[goalId] = block.timestamp;
        
        emit Staked(goalId, amount);
    }
    
    function unstake(uint256 goalId) external nonReentrant returns (uint256, uint256) {
        uint256 amount = stakedBalances[goalId];
        require(amount > 0, "No staked balance");
        
        uint256 rewards = calculateRewards(goalId);
        stakedBalances[goalId] = 0;
        
        emit Unstaked(goalId, amount, rewards);
        return (amount, rewards);
    }
    
    function calculateRewards(uint256 goalId) public view returns (uint256) {
        if (stakedBalances[goalId] == 0) return 0;
        
        uint256 duration = block.timestamp - stakingStartTime[goalId];
        return (stakedBalances[goalId] * duration * 5) / 10000; // 5% APY simplified
    }
}
