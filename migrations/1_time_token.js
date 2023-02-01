const TimeToken = artifacts.require("TimeToken");
let _owner = "";

module.exports = async function (deployer, _network, accounts) {
    
    if (_network == "matic") {
        // Warning this seed must be protected because it's mainnet settings.
        _owner = "0x6A60495E3c5345D8Bbf1CE04B20B93edE0d7d84C";
    } else if (_network == "development") {
        _owner = accounts[0];
    } else {
        _owner = "0x6A60495E3c5345D8Bbf1CE04B20B93edE0d7d84C";
    }

    await deployer.deploy(TimeToken, _owner);
}