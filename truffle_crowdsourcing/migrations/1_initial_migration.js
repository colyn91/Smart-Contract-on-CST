var Migrations = artifacts.require("./Migrations.sol");
var SOBP = artifacts.require("./SOBP.sol");
module.exports = function(deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(SOBP);
};
