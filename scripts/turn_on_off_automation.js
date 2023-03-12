const TimeToken = artifacts.require("TimeToken");

module.exports = async function(callback) {
    const _instanceTimeToken = await TimeToken.deployed();

    try {
        const _interval = await _instanceTimeToken.interval.call();
        const _isOn = await _instanceTimeToken.isOn.call();

        console.log(_isOn);
        console.log(_interval.toString());

        await _instanceTimeToken.setVariables(_interval.toString(), !_isOn);
        
        if(_isOn) {
            console.log("Automation was turned off.");
        } else {
            console.log("Automation was turned on.");
        }
        
    } catch (err) {
        console.error(err);
    }
    callback();
}