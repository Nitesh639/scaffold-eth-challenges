const { ethers } = require("hardhat");

// const localChainId = "31337";

module.exports = async ({ getNamedAccounts, deployments, getChainId }) => {
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();
  const chainId = await getChainId();

  const diceGame = await ethers.getContract("DiceGame", deployer);

  await deploy("RiggedRoll", {
   from: deployer,
   args: [diceGame.address],
   log: true,
  });


  const riggedRoll = await ethers.getContract("RiggedRoll", deployer);

  // const ownershipTransaction = await riggedRoll.transferOwnership(vender.address);
  if (chainId !== "31337") {
    try {
      console.log(" 🎫 Verifing Contract on Etherscan... ");
      await sleep(50000);
      await run("verify:verify", {
        address: riggedRoll.address,
        contract: "contracts/RiggedRoll.sol:RiggedRoll",
        constructorArguments: [diceGame.address],
      });
    } catch (e) {
      console.log(" ⚠️ Failed to verify contract on Etherscan ");
    }
  }
};

function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

module.exports.tags = ["RiggedRoll"];
