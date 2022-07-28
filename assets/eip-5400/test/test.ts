import { expect } from "chai";
import { ethers } from "hardhat";
import { BigNumber } from "ethers";

describe("ERC5400", function () {
  it("Set beneficiary", async function () {
    const ERC5400 = await ethers.getContractFactory("ERC5400Demo");
    const erc5400 = await ERC5400.deploy("ERC5400", "ERC5400");
    await erc5400.deployed();

    const [_, owner, beneficiary] = await ethers.getSigners();
    await erc5400.mint(BigNumber.from(1), owner.address);
    expect(await erc5400.beneficiaryOf(BigNumber.from(1))).to.equal(
      owner.address
    );
    await erc5400
      .connect(owner)
      .setBeneficiary(BigNumber.from(1), beneficiary.address);
    expect(await erc5400.beneficiaryOf(BigNumber.from(1))).to.equal(
      beneficiary.address
    );
  });
});
