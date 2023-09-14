

import { ethers } from 'hardhat';

async function main() {


const  CatContract =	'0xe2a1FcD65Ab92a203280Ed326DD6395499CbB7c8'

const ownerAddr = '0xe9999a29B116cB45444621EcD1CE52CA013243E4'
  const Kitty = await ethers.getContractAt(
    "INFT",
    "0xe2a1FcD65Ab92a203280Ed326DD6395499CbB7c8"
  );
  await Kitty.requestNewRandomCharacter(ownerAddr,6, "ipfs://bafkreibewwt2yosste3zq44zxw7xhajqpodlklebbtcqqpr6mora7twhlu" );

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
