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
        assert(await mstToken.balanceOf(user1), 1000);
        assert(await mstToken.balanceOf(user2), 0);
        assert(await mstToken.balanceOf(other), 0);
        assert(await mstToken.allowance(user1, user2), 0);

        await mstToken.approve(user2, 500, {from: user1});

        assert(await mstToken.balanceOf(user1), 1000);
        assert(await mstToken.balanceOf(user2), 0);
        assert(await mstToken.balanceOf(other), 0);
        assert(await mstToken.allowance(user1, user2), 500);

        await mstToken.increaseAllowance(user2, 250, {from: user1});

        assert(await mstToken.balanceOf(user1), 1000);
        assert(await mstToken.balanceOf(user2), 0);
        assert(await mstToken.balanceOf(other), 0);
        assert(await mstToken.allowance(user1, user2), 750);

    });

    it('should decreaseAllowance', async function () {
        assert(await mstToken.balanceOf(user1), 1000);
        assert(await mstToken.balanceOf(user2), 0);
        assert(await mstToken.balanceOf(other), 0);
        assert(await mstToken.allowance(user1, user2), 0);

        await mstToken.approve(user2, 500, {from: user1});

        assert(await mstToken.balanceOf(user1), 1000);
        assert(await mstToken.balanceOf(user2), 0);
        assert(await mstToken.balanceOf(other), 0);
        assert(await mstToken.allowance(user1, user2), 500);

        await mstToken.decreaseAllowance(user2, 250, {from: user1});

        assert(await mstToken.balanceOf(user1), 1000);
        assert(await mstToken.balanceOf(user2), 0);
        assert(await mstToken.balanceOf(other), 0);
        assert(await mstToken.allowance(user1, user2), 250);

    });

  });

  describe('as ERC20Pausable', async function () {
    beforeEach(async function() {
      mstToken = await MSTToken.new("MSTTest Token", "MST", 18);
      await mstToken.mint(user1, 1000);
    });

    it('should be unpaused by default', async function () {
        assert.equal(await mstToken.paused(), false);
    });

    it('should pause', async function () {
        assert.equal(await mstToken.paused(), false);
        await mstToken.pause();
        assert.equal(await mstToken.paused(), true);
    });

    it('should unpause', async function () {
        assert.equal(await mstToken.paused(), false);
        await mstToken.pause();
        assert.equal(await mstToken.paused(), true);
        await mstToken.unpause();
        assert.equal(await mstToken.paused(), false);
    });

    it('should not allow transfer when paused', async function () {
        assert.equal(await mstToken.paused(), false);
        await mstToken.pause();
        assert.equal(await mstToken.paused(), true);

        await shouldFail.reverting(
            mstToken.transfer(user2, 100, {from: user1})
        );

        assert(await mstToken.balanceOf(user1), 1000);
        assert(await mstToken.balanceOf(user2), 0);
    });

    it('should not allow transferFrom when paused', async function () {
        assert(await mstToken.allowance(user1, user2), 0);
        await mstToken.approve(user2, 500, {from: user1});
        assert(await mstToken.allowance(user1, user2), 500);

        assert.equal(await mstToken.paused(), false);
        await mstToken.pause();
        assert.equal(await mstToken.paused(), true);

        await shouldFail.reverting(
            mstToken.transferFrom(user1, user2, 100, {from: user2})
        );

        assert(await mstToken.allowance(user1, user2), 500);
        assert(await mstToken.balanceOf(user1), 1000);
        assert(await mstToken.balanceOf(user2), 0);
    });

    it('should not allow approve when paused', async function () {
        assert.equal(await mstToken.paused(), false);
        await mstToken.pause();
        assert.equal(await mstToken.paused(), true);

        assert(await mstToken.allowance(user1, user2), 0);
        await shouldFail.reverting(
            mstToken.approve(user2, 500, {from: user1})
        );
        assert(await mstToken.allowance(user1, user2), 0);

    });

    it('should not allow increaseAllowance when paused', async function () {
        assert.equal(await mstToken.paused(), false);
        await mstToken.pause();
        assert.equal(await mstToken.paused(), true);

        assert(await mstToken.allowance(user1, user2), 0);
        await shouldFail.reverting(
            mstToken.increaseAllowance(user2, 500, {from: user1})
        );
        assert(await mstToken.allowance(user1, user2), 0);

    });

    it('should not allow decreaseAllowance when paused', async function () {
        assert.equal(await mstToken.paused(), false);
        await mstToken.pause();
        assert.equal(await mstToken.paused(), true);

        assert(await mstToken.allowance(user1, user2), 0);
        await shouldFail.reverting(
            mstToken.decreaseAllowance(user2, 500, {from: user1})
        );
        assert(await mstToken.allowance(user1, user2), 0);

    });


  });

  describe('as ERC20Burnable', async function () {
    beforeEach(async function() {
      mstToken = await MSTToken.new("MSTTest Token", "MST", 18);
      await mstToken.mint(user1, 1000);
    });

    it('should burn', async function () {
        assert.equal(await mstToken.balanceOf(user1), 1000);
        assert.equal(await mstToken.totalSupply(), 1000);

        await mstToken.burn(100, {from: user1});

        assert.equal(await mstToken.balanceOf(user1), 900);
        assert.equal(await mstToken.totalSupply(), 900);
    });

    it('should burnFrom', async function () {
        assert.equal(await mstToken.balanceOf(user1), 1000);
        assert.equal(await mstToken.balanceOf(user2), 0);
        assert.equal(await mstToken.allowance(user1, user2), 0);
        assert.equal(await mstToken.totalSupply(), 1000);

        await mstToken.approve(user2, 200, {from: user1});
        assert.equal(await mstToken.allowance(user1, user2), 200);
        await mstToken.burnFrom(user1, 100, {from: user2});

        assert.equal(await mstToken.balanceOf(user1), 900);
        assert.equal(await mstToken.balanceOf(user2), 0);
        assert.equal(await mstToken.allowance(user1, user2), 100);
        assert.equal(await mstToken.totalSupply(), 900);
    });

  });

});