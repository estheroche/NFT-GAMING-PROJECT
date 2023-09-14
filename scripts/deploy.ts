import { ethers } from "hardhat";

async function main() {
  

  const Contract =	'0x567B6fcc497386c48Cf91BA98Bea76762368F269'

 // const ownerAddr = '0xe9999a29B116cB45444621EcD1CE52CA013243E4'
    const request = await ethers.getContractAt(
      "VRFinterface.",
      "0x567B6fcc497386c48Cf91BA98Bea76762368F269"
    );
    await request.mint(Contract,1, "ipfs://bafkreibewwt2yosste3zq44zxw7xhajqpodlklebbtcqqpr6mora7twhlu" );
   
  }
  

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
