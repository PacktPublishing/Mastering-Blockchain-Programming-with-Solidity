var DeploymentExample = artifacts.require("DeploymentExample.sol");

module.exports = function(deployer) {
  deployer.deploy(DeploymentExample);
};
