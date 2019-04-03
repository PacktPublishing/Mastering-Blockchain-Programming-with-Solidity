const { expectEvent, shouldFail } = require('openzeppelin-test-helpers');

const MSTToken = artifacts.require('MSTToken');

let mstToken;

contract('MSTToken', function (accounts) {
  beforeEach(async function () {
    mstToken = await MSTToken.new("MSTTest Token", "MST", 18);

    //accounts
    owner = accounts[0];
    user1 = accounts[1];
    user2 = accounts[2];
    other = accounts[3];
  });

  describe('as ERC20Detailed', async function () {
    it('should have token name', async function () {
        let name  = await mstToken.name();
        assert.equal(name, "MSTTest Token");
    });

    it('should have token symbol', async function () {
        let symbol = await mstToken.symbol();
        assert.equal(symbol, "MST");
    });

    it('should have token decimals', async function () {
        let decimals = await mstToken.decimals();
        assert.equal(decimals, 18);
    });
  });

  describe('as ERC20Mintable', async function () {
    it('owner should have minter role', async function () {
        let isMinter = await mstToken.isMinter(owner);
        assert.equal(isMinter, true);
    });

    it('minter should mint', async function () {
        assert(await mstToken.balanceOf(user1), 0);
        let isMinter = await mstToken.mint(user1, 100);
        assert(await mstToken.balanceOf(user1), 100);
    });
  });

  describe('as ERC20', async function () {
    beforeEach(async function() {
      mstToken = await MSTToken.new("MSTTest Token", "MST", 18);
      await mstToken.mint(user1, 1000);
    });

    it('should return totalSupply', async function () {
        assert(await mstToken.totalSupply(), 1000);
    });

    it('should return balanceOf', async function () {
        assert(await mstToken.balanceOf(owner), 0);
        assert(await mstToken.balanceOf(user1), 1000);
        assert(await mstToken.balanceOf(user2), 0);
        assert(await mstToken.balanceOf(other), 0);
    });

    it('should transfer', async function () {
        await mstToken.transfer(user2, 500, {from: user1});
        assert(await mstToken.balanceOf(user1), 500);
        assert(await mstToken.balanceOf(user2), 500);
    });

    it('should fail transfer', async function () {
        await shouldFail.reverting(
            mstToken.transfer(user2, 500, {from: owner})
        );
        assert(await mstToken.balanceOf(owner), 0);
        assert(await mstToken.balanceOf(user1), 1000);
        assert(await mstToken.balanceOf(user2), 0);
        assert(await mstToken.balanceOf(other), 0);
    });

    it('should approve', async function () {
        assert(await mstToken.allowance(user1, user2), 0);

        await mstToken.approve(user2, 500, {from: user1});

        assert(await mstToken.balanceOf(user1), 1000);
        assert(await mstToken.balanceOf(user2), 0);
        assert(await mstToken.allowance(user1, user2), 500);
    });

    it('should return allowance', async function () {
        assert(await mstToken.allowance(user1, user2), 0);

        await mstToken.approve(user2, 1000, {from: user1});

        assert(await mstToken.balanceOf(user1), 1000);
        assert(await mstToken.balanceOf(user2), 0);
        assert(await mstToken.allowance(user1, user2), 1000);
    });

    it('should transferFrom', async function () {
        assert(await mstToken.balanceOf(user1), 1000);
        assert(await mstToken.balanceOf(user2), 0);
        assert(await mstToken.balanceOf(other), 0);
        assert(await mstToken.allowance(user1, user2), 0);

        await mstToken.approve(user2, 500, {from: user1});

        assert(await mstToken.balanceOf(user1), 1000);
        assert(await mstToken.balanceOf(user2), 0);
        assert(await mstToken.balanceOf(other), 0);
        assert(await mstToken.allowance(user1, user2), 500);

        await mstToken.transferFrom(user1, other, 250, {from: user2});

        assert(await mstToken.balanceOf(user1), 750);
        assert(await mstToken.balanceOf(user2), 0);
        assert(await mstToken.balanceOf(other), 250);
        assert(await mstToken.allowance(user1, user2), 250);
    });

    it('should increaseAllowance', async function () {

    });

    it('should decreaseAllowance', async function () {

    });

  });

});