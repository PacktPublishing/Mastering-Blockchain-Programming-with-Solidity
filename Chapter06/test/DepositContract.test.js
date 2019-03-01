var BigNumber = require('bignumber.js');
const { expectThrow } = require('./helpers/expectThrow');
const { EVMRevert } = require('./helpers/EVMRevert');
const { shouldBehaveLikeOwnable } = require('./ownership/Ownable.behaviour');

const DepositContract = artifacts.require('DepositContract');

let depositContract;

contract('DepositContract', function (accounts) {
  beforeEach(async function () {
    //For ownable behavior
    this.ownable = await DepositContract.new();
    depositContract = this.ownable;

    //accounts
    owner = accounts[0];
    user1 = accounts[1];
    user2 = accounts[2];
    other = accounts[3];
  });

  describe('as DepositContract', function () {

    it('should fail when deposit 0 ether using fallback', async function () {
      await expectThrow(
        web3.eth.sendTransaction({
          from: user1,
          to: depositContract.address,
          value: web3.utils.toWei("0" , "ether")
        }),
        EVMRevert
      );
      const balance = await web3.eth.getBalance(depositContract.address);
      assert.equal(balance, web3.utils.toWei("0" , "ether"));
    });

    it('should deposit 1 ether using fallback', async function () {
      await web3.eth.sendTransaction({
        from: user1,
        to: depositContract.address,
        value: web3.utils.toWei("1" , "ether")
      });
      const balance = await web3.eth.getBalance(depositContract.address);
      assert.equal(balance, web3.utils.toWei("1" , "ether"));
    });

    it('should fail when deposit 0 ether using depositEther()', async function () {
      await expectThrow(depositContract.depositEther({from: user1}), EVMRevert);
      const balance = await web3.eth.getBalance(depositContract.address);
      assert.equal(balance, 0);
    });

    it('should deposit 1 ether using depositEther()', async function () {
      await depositContract.depositEther(
        {from: user1, value: web3.utils.toWei("1" , "ether")});
      const balance = await web3.eth.getBalance(depositContract.address);
      assert.equal(balance, web3.utils.toWei("1" , "ether"));
    });

    it('should withdraw', async function () {
      //deposit
      await depositOneEther(user1);

      //Withdraw
      await withdraw(web3.utils.toWei("1" , "ether"), user1, 0);
    });

    it('should withdraw multiple', async function() {
      //deposit
      await depositOneEther(user2);

      //withdraw
      var amountToWithdaw = web3.utils.toWei("0.3", "ether");
      var balanceRemaining = web3.utils.toWei("0.7", "ether");
      await withdraw(amountToWithdaw, user2, balanceRemaining);

      amountToWithdaw = web3.utils.toWei("0.3", "ether");
      balanceRemaining = web3.utils.toWei("0.4", "ether");
      await withdraw(amountToWithdaw, user2, balanceRemaining);

      amountToWithdaw = web3.utils.toWei("0.4", "ether");
      await withdraw(amountToWithdaw, user2, 0);
    });

    it('should not withdraw more than balance', async function() {
      //deposit
      await depositOneEther(user2);

      //Withdraw
      await withdraw(web3.utils.toWei("1" , "ether"), user2, 0);
      await expectThrow(depositContract.withdraw(1, {from: user2}), EVMRevert);
    });

    it('should not withdrawn by non depositor', async function() {
      //deposit
      await depositOneEther(user1);

      //Withdraw
      await expectThrow(depositContract.withdraw(1, {from: user2}), EVMRevert);
    });
  });

  describe('as Pausable', function () {
    it('should allow owner to pause', async function () {
      var isPaused = await depositContract.paused();
      assert.isFalse(isPaused);

      await depositContract.pause();

      isPaused = await depositContract.paused();
      assert.isTrue(isPaused);
    });

    it('should allow owner to un-pause', async function () {
      var isPaused = await depositContract.paused();
      assert.isFalse(isPaused);

      await depositContract.pause();

      isPaused = await depositContract.paused();
      assert.isTrue(isPaused);

      await depositContract.unpause();

      isPaused = await depositContract.paused();
      assert.isFalse(isPaused);
    });

    it('should not allow non-owner to pause', async function () {
      await expectThrow(depositContract.pause({from: other}), EVMRevert);

      isPaused = await depositContract.paused();
      assert.isFalse(isPaused);
    });

    it('should not allow non-owner to un-pause', async function () {
      await depositContract.pause({from: owner});

      await expectThrow(depositContract.unpause({from: other}), EVMRevert);

      isPaused = await depositContract.paused();
      assert.isTrue(isPaused);
    });

    it('should allow deposit in non-pause', async function () {
      //deposit, default is non-pause
      await depositOneEther(user1);
    });

    it('should not allow deposit in pause', async function () {
        await depositContract.pause();

        await expectThrow(depositOneEther(user1), EVMRevert);
    });

    it('should resume deposit after pause is over', async function () {
      isPaused = await depositContract.paused();
      assert.isFalse(isPaused);

      //deposit
      await depositOneEther(user1);

      await depositContract.pause({from: owner});
      isPaused = await depositContract.paused();
      assert.isTrue(isPaused);

      await expectThrow(depositOneEther(user1), EVMRevert);

      await depositContract.unpause({from: owner});
      isPaused = await depositContract.paused();
      assert.isFalse(isPaused);

      await depositOneEther(user1);
    });

    it('should allow withdraw in non-pause', async function() {
      isPaused = await depositContract.paused();
      assert.isFalse(isPaused);

      //deposit
      await depositOneEther(user1);

      //Withdraw
      await withdraw(web3.utils.toWei("1" , "ether"), user1, 0);
    });

    it('should allow withdraw in pause', async function () {
      isPaused = await depositContract.paused();
      assert.isFalse(isPaused);

      //deposit
      await depositOneEther(user1);

      await depositContract.pause({from: owner});
      isPaused = await depositContract.paused();
      assert.isTrue(isPaused);

      //Withdraw
      await withdraw(web3.utils.toWei("1" , "ether"), user1, 0);
    });
  });

  shouldBehaveLikeOwnable(accounts);
});

async function depositOneEther(user) {
  var oldContractBalance = new BigNumber(await web3.eth.getBalance(depositContract.address));
  var oldUserBalance = new BigNumber(await depositContract.balances(user));
  await depositContract.depositEther(
    {from: user, value: web3.utils.toWei("1" , "ether")});
  var contractBalance = new BigNumber(await web3.eth.getBalance(depositContract.address));

  assert.isTrue(contractBalance.eq(oldContractBalance.plus(new BigNumber(web3.utils.toWei("1" , "ether")))));

  var userBalance = new BigNumber(await depositContract.balances(user));
  assert.isTrue(userBalance.eq(oldUserBalance.plus(new BigNumber(web3.utils.toWei("1", "ether")))));
}

async function withdraw(amount, user, balanceRemaining) {
  const userEthBalance = new BigNumber(await web3.eth.getBalance(user));
  const txnReceipt = await depositContract.withdraw(
    amount, {from: user});

  const tx = await web3.eth.getTransaction(txnReceipt.tx);
  const gasPrice = new BigNumber(tx.gasPrice);
  const gasUsed = new BigNumber(txnReceipt.receipt.gasUsed);
  const gasCost = gasPrice.times(gasUsed);

  const updatedContractBalance = await web3.eth.getBalance(depositContract.address);
  assert.equal(updatedContractBalance, balanceRemaining);

  const userBalanceAfter = await depositContract.balances(user);
  assert.equal(userBalanceAfter, balanceRemaining);

  const userEthBalanceAfter = await web3.eth.getBalance(user);
  assert.isTrue(userEthBalance.minus(gasCost).eq(
    new BigNumber(userEthBalanceAfter - amount)));
}