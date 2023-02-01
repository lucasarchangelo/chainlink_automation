const TimeToken = artifacts.require("TimeToken");

contract("TimeToken", (accounts) => {
    let timeTokenInstance;
    const _baseURL = "https://clashcardschampions.infura-ipfs.io/ipfs/";
    const MORNING = "QmeEM9pswM8ei2AeHrBGfbDzba9eBCZTL7xdpQD7S3VY5N";
    const AFTERMOON = "QmQxdL8vK1g1qtR73vA4o3gFZf8gYwpod4zRHgTrfb62Qh";
    const NIGHT = "QmYwCQb3VFC6x5WH5AM3QcdY9r7v3znZfUY1aZ2SEwKNqz";
    before(async () => {
        timeTokenInstance = await TimeToken.deployed();
    });

    it("should call safeMint and get a NFT", async () => {
        const balanceBefore = await timeTokenInstance.balanceOf.call(accounts[0]);
        await timeTokenInstance.safeMint(accounts[0], { from: accounts[0] });
        const balanceAfter = await timeTokenInstance.balanceOf.call(accounts[0]);
        assert.ok(balanceAfter.toString() > balanceBefore.toString(), "NFT wasn't minted");
    });

    it("onlyOwner should call safeMint", async() => {
        try {
            await timeTokenInstance.safeMint(accounts[1], { from: accounts[1] });
            assert.ok(false);
        } catch(err) {
            assert.ok(true);
        }
        
    });

    it("NFT should start with MORNING status", async() => {
        const verifyURL = _baseURL + MORNING;

        const tokenURL = await timeTokenInstance.tokenURI.call(1);
        assert.equal(verifyURL, tokenURL);
    });

    it("should setVariable with success", async() => {
        const shouldSetInterval = "1";
        const souldSetIsOn = true;

        await timeTokenInstance.setVariables(shouldSetInterval, souldSetIsOn);

        const interval = await timeTokenInstance.interval.call();
        const isOn = await timeTokenInstance.isOn.call();

        assert.equal(interval, shouldSetInterval, "Error Interval wasn't change");
        assert.equal(isOn, souldSetIsOn, "Error IsOn wasn't change");
    });
});