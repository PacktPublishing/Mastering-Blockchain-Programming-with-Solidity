const MSTToken = artifacts.require("MSTToken");
const MSTCrowdsale = artifacts.require("MSTCrowdsale");

var BigNumber = require('big-number');

module.exports = async function(deployer, network, accounts) {
  var owner = accounts[0];
  var wallet = accounts[1];

  await deployer.deploy(MSTToken);

  var milliseconds = (new Date).getTime(); // Today time
  var currentTimeInSeconds = parseInt(milliseconds / 1000);
  var oneDayInSeconds = 86400;
  var openingTime = currentTimeInSeconds + oneDayInSeconds; // openingTime next day
  var closingTime = openingTime + (oneDayInSeconds * 90); // closingTime after 90 days
  var rate = 1000; //1000 MST tokens per eather
  var cap = BigNumber(10000).pow(18);
  await deployer.deploy(MSTCrowdsale, rate, wallet, MSTToken.address, openingTime, closingTime, cap);

};
