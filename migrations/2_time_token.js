const TimeToken = artifacts.require("TimeToken");

module.exports = async function (deployer, _network, accounts) {
    await deployer.deploy(TimeToken);
}