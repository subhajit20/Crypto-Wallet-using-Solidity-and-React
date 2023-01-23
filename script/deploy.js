const hre = require("hardhat");
const { ethers} = require("hardhat");

async function main() {
  const [owner] = await ethers.getSigners();

  const Test = await hre.ethers.getContractFactory("CryptoWallet");

  const contract1 = await Test.connect(owner).deploy();

  console.log(`deployed ${contract1.address}`);
}
// contract address = 0x5FbDB2315678afecb367f032d93F642f64180aa3

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});