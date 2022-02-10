const wildBets = artifacts.require("wildBets");

module.exports = function (deployer) {
  deployer.deploy(wildBets);
};
