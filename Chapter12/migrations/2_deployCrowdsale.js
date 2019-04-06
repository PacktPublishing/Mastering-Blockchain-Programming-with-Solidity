const MSTToken = artifacts.require("MSTToken");
const MSTCrowdsale = artifacts.require("MSTCrowdsale");

var BigNumber = require('big-number');

module.exports = async function(deployer, network, accounts) {
  var owner = accounts[0];
  var wallet = accounts[9];

  //1. Deploy MSTToken
  await deployer.deploy(MSTToken, "Mastering Solidity Token", "MST", 18);

  //2. Deploy MSTCrowdsale
  var milliseconds = (new Date).getTime(); // Today time
  var currentTimeInSeconds = parseInt(milliseconds / 1000);
  var oneDayInSeconds = 86400;
  var openingTime = currentTimeInSeconds + 60; // openingTime after a minute
  var closingTime = openingTime + (oneDayInSeconds * 90); // closingTime after 90 days
  var rate = 1000; //1000 MST tokens per ether
  var cap = BigNumber(10000).pow(18); // 10000 ** 18 = 10000 ether

  await deployer.deploy(
    MSTCrowdsale,
    rate,
    wallet,
    MSTToken.address,
    openingTime,
    closingTime,
    cap
  );

  //3. Owner Adds MinterRole for MSTCrowdsale
  var mstToken = await MSTToken.deployed();
  mstToken.addMinter(MSTCrowdsale.address);

  //4. Owner Renounce Minter
  mstToken.renounceMinter();

};
