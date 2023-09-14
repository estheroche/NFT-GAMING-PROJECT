

import { ethers } from 'hardhat';

async function main() {


  const Contract =	'0x567B6fcc497386c48Cf91BA98Bea76762368F269'

  const Kitty = await ethers.getContractAt(
    "VRFinterface",
    "0x567B6fcc497386c48Cf91BA98Bea76762368F269"
  );
  await Kitty.requestNewRandomTrait(ownerAddr,0, "ipfs://bafkreibewwt2yosste3zq44zxw7xhajqpodlklebbtcqqpr6mora7twhlu" );
   await Kitty.requestNewRandomTrait(ownerAddr,1, "ipfs://ipfs://bafkreid43slp3gzbcuynqdarlren77efarp24edwfuwhk4dewy5ig6dbhi" );
 await Kitty.requestNewRandomTrait(ownerAddr,2, "ipfs://ipfs://ipfs://bafkreibewwt2yosste3zq44zxw7xhajqpodlklebbtcqqpr6mora7twhlu" );
  await Kitty.requestNewRandomTrait(ownerAddr,3, "ipfs://bafkreibewwt2yosste3zq44zxw7xhajqpodlklebbtcqqpr6mora7twhlu" );
   await Kitty.requestNewRandomTrait(ownerAddr,4, "ipfs://bafkreibewwt2yosste3zq44zxw7xhajqpodlklebbtcqqpr6mora7twhlu" );
    await Kitty.requestNewRandomTrait(ownerAddr,5, "ipfs://ipfs://bafkreid43slp3gzbcuynqdarlren77efarp24edwfuwhk4dewy5ig6dbhi" );

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
