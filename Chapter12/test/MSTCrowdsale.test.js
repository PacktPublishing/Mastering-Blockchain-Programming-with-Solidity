const { BN, ether, shouldFail, time } = require('openzeppelin-test-helpers');
const MSTCrowdsale = artifacts.require('MSTCrowdsale');
const MSTToken = artifacts.require('MSTToken');

let mstCrowdsale;
let mstToken;

contract('MSTCrowdsale', function (accounts) {
  beforeEach(async function () {
    mstCrowdsale = await MSTCrowdsale.deployed();
    mstToken = await MSTToken.deployed();

    //accounts
    owner = accounts[0];
    user1 = accounts[1];
    user2 = accounts[2];
    other = accounts[3];
  });

  describe('as TimedCrowdsale', async function () {
    it('should have crowdsale openTime', async function () {
        assert(await mstCrowdsale.openingTime() > 0);
    });

    it('should have crowdsale closingTime', async function () {
        assert(await mstCrowdsale.closingTime() > 0);
    });

    it('should not hasClosed', async function () {
        assert.equal(await mstCrowdsale.hasClosed(), false);
    });

    it('should not isOpen', async function () {
        assert.equal(await mstCrowdsale.isOpen(), false);
    });

    it('should Open crowdsale', async function () {
        await time.increaseTo(await mstCrowdsale.openingTime());
        assert.equal(await mstCrowdsale.isOpen(), true);
        assert.equal(await mstCrowdsale.hasClosed(), false);
    });


  });
});

contract('MSTCrowdsale', function (accounts) {
  beforeEach(async function () {
    mstCrowdsale = await MSTCrowdsale.deployed();

    //accounts
    owner = accounts[0];
    user1 = accounts[1];
    user2 = accounts[2];
    other = accounts[3];
    wallet = accounts[9];
  });

  describe('as Crowdsale', async function () {
    it('should default to zero', async function () {
        assert.equal(await mstCrowdsale.weiRaised(), 0);
    });

    it('should open crowdsale', async function () {
        await time.increaseTo(await mstCrowdsale.openingTime());
        assert.equal(await mstCrowdsale.isOpen(), true);
        assert.equal(await mstCrowdsale.hasClosed(), false);
    });

    it('should mint MST when ETH received', async function () {
        const prevWalletBal = new BN(await web3.eth.getBalance(wallet));
        const value = ether('1');
        const mstBalance = new BN('10').pow(new BN('21'));
        assert.equal(await mstCrowdsale.weiRaised(), 0);
        mstCrowdsale.buyTokens(user1, {from: user1, value: value});
        assert( (await mstCrowdsale.weiRaised()).eq(value) );

        assert( (await mstToken.balanceOf(user1)).eq(mstBalance) );

        const currWalletBal = new BN(await web3.eth.getBalance(wallet));
        assert(prevWalletBal.add(value).eq(currWalletBal));
    });

  });
});
