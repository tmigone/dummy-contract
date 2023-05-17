import { task } from "hardhat/config";
import { HardhatRuntimeEnvironment } from "hardhat/types";

task("deploy", "Deploy the raffle contract").setAction(
  async (_, hre: HardhatRuntimeEnvironment) => {
    const accounts = await hre.ethers.getSigners();
    const deployer = accounts[0];

    if (accounts.length === 0) {
      throw new Error("No accounts available, set MNEMONIC env variable");
    }

    console.log("-- Raffle contract --");
    console.log(`Using deployer: ${deployer.address}`);

    const NotAScam = await hre.ethers.getContractFactory("NotAScam");
    const notAScam = await NotAScam.connect(deployer).deploy(deployer.address);
    const deployedContract = await notAScam.deployed();
    console.log(`Deployed at: ${deployedContract.address}`);
    
  }
);