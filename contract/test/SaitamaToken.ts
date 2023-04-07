import { ethers } from 'hardhat';
import { expect } from 'chai';

describe('SaitamaToken', function () {
  before(async function () {
    const availableAccounts = await ethers.getSigners();
    this.owner = availableAccounts[0];

    const SaitamaToken = await ethers.getContractFactory('SaitamaToken');
    this.saitamaToken = await SaitamaToken.deploy('Saitama Token', 'SAI');

    await this.saitamaToken.deployed();
  });

  it('should have a name', async function () {
    expect(await this.saitamaToken.name()).to.equal('Saitama Token');
  });

  it('should have a symbol', async function () {
    expect(await this.saitamaToken.symbol()).to.equal('SAI');
  });

  it('should have 18 decimals', async function () {
    expect(await this.saitamaToken.decimals()).to.equal(18);
  });

  it('should have an initial supply of 1000000000000000000000000', async function () {
    expect(await this.saitamaToken.totalSupply()).to.equal(
      ethers.utils.parseEther('1000000')
    );
  });

  it('should assign the total supply of tokens to the owner', async function () {
    expect(await this.saitamaToken.balanceOf(this.owner.address)).to.equal(
      ethers.utils.parseEther('1000000')
    );
  });

  it('should transfer tokens between accounts', async function () {
    const availableAccounts = await ethers.getSigners();
    const recipient = availableAccounts[1];
    const amount = ethers.utils.parseEther('100');

    await this.saitamaToken.transfer(recipient.address, amount);

    expect(await this.saitamaToken.balanceOf(this.owner.address)).to.equal(
      ethers.utils.parseEther('999900')
    );
    expect(await this.saitamaToken.balanceOf(recipient.address)).to.equal(
      amount
    );
  });
});
