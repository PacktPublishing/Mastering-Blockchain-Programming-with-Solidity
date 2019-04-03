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
    it('should return totalSupply', async function () {

    });

    it('should return balanceOf', async function () {

    });

    it('should transfer', async function () {

    });

    it('should approve', async function () {

    });

    it('should return allowance', async function () {

    });

    it('should transferFrom', async function () {

    });

    it('should increaseAllowance', async function () {

    });

    it('should decreaseAllowance', async function () {

    });

  });

});