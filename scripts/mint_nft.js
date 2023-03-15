const TimeToken = artifacts.require("TimeToken");

module.exports = async function(callback) {
    const accounts = await web3.eth.getAccounts();
    const _instanceTimeToken = await TimeToken.deployed();
    try {
        console.log("Creating an awesome NFT...");
        await _instanceTimeToken.safeMint(accounts[0]);
        console.log(`NFT created for wallet ${accounts[0]}`);
    } catch (err) {
        console.error(err);
    }
    
    callback();
}