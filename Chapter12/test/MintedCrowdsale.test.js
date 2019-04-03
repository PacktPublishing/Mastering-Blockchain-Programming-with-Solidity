const { BN, ether, shouldFail } = require('openzeppelin-test-helpers');
const { shouldBehaveLikeMintedCrowdsale } = require('./MintedCrowdsale.behavior');

const MintedCrowdsaleImpl = artifacts.require('MintedCrowdsaleImpl');
const MSTToken = artifacts.require('MSTToken');
const ERC20 = artifacts.require('ERC20');

contract('MintedCrowdsale', function ([_, deployer, investor, wallet, purchaser]) {
  const rate = new BN('1000');
  const value = ether('5');

  describe('using ERC20Mintable', function () {
    beforeEach(async function () {
      this.token = await MSTToken.new({ from: deployer });
      this.crowdsale = await MintedCrowdsaleImpl.new(rate, wallet, this.token.address);

      await this.token.addMinter(this.crowdsale.address, { from: deployer });
      await this.token.renounceMinter({ from: deployer });
    });

    it('crowdsale should be minter', async function () {
      (await this.token.isMinter(this.crowdsale.address)).should.equal(true);
    });

    shouldBehaveLikeMintedCrowdsale([_, investor, wallet, purchaser], rate, value);
  });

});
