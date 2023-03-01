const TimeToken = artifacts.require("TimeToken");

module.exports = async function(callback) {
    const accounts = await web3.eth.getAccounts();
    const _instanceTimeToken = await TimeToken.deployed();
    try {
        await _instanceTimeToken.safeMint(accounts[0]);
    } catch (err) {
        console.error(err);
    }
    
    callback();
}