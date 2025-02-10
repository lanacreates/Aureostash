const hre = require("hardhat");

async function main() {
  console.log("Deploying AureoStash contracts...");

  // Deploy StakingManager
  const StakingManager = await hre.ethers.getContractFactory("StakingManager");
  const stakingManager = await StakingManager.deploy();
  await stakingManager.deploymentTransaction().wait();
  console.log("StakingManager deployed to:", stakingManager.target);

  // Deploy AureoStash with StakingManager address
  const AureoStash = await hre.ethers.getContractFactory("AureoStash");
  const aureoStash = await AureoStash.deploy(stakingManager.target);
  await aureoStash.deploymentTransaction().wait();
  console.log("AureoStash deployed to:", aureoStash.target);

  console.log("Deployment completed!");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });