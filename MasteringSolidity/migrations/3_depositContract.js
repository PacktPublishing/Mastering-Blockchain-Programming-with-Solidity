var DepositContract = artifacts.require("DepositContract");

module.exports = function(deployer) {
  deployer.deploy(DepositContract);
};
