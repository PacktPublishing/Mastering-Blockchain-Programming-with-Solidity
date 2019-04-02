const MSTToken = artifacts.require("MSTToken");
const MSTCrowdsale = artifacts.require("MSTCrowdsale");

module.exports = function(deployer, network, accounts) {
  var owner = accounts[0];
  var wallet = accounts[1];

  deployer.deploy(MSTToken, "Mastering Solidity Token", "MST", 18);

  var startTime = 1554076800; // 01 Apr 2019 00:00:00 GMT
  //deployer.deploy(MSTCrowdsale, startTime, wallet, MSTToken.address)
};
