// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

import "@chainlink/contracts/src/v0.8/AutomationCompatible.sol";

contract TimeToken is
    ERC721,
    ERC721Burnable,
    Ownable,
    AutomationCompatibleInterface
{
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    uint256 public interval = 8 hours;
    bool public isOn = true;

    enum TimeType {
        MORNING,
        AFTERMOON,
        NIGHT
    }

    struct DayAttribute {
        TimeType timeType;
        uint256 lastChange;
    }

    string private constant MORNING =
        "QmeEM9pswM8ei2AeHrBGfbDzba9eBCZTL7xdpQD7S3VY5N";
    string private constant AFTERMOON =
        "QmQxdL8vK1g1qtR73vA4o3gFZf8gYwpod4zRHgTrfb62Qh";
    string private constant NIGHT =
        "QmYwCQb3VFC6x5WH5AM3QcdY9r7v3znZfUY1aZ2SEwKNqz";

    mapping(uint256 => DayAttribute) dayAttributes;
    uint256[] listTokens;

    constructor(address _owner) ERC721("TimeToken", "TIC") {
        //Start Counter by 1
        _tokenIdCounter.increment();

        if(msg.sender != _owner) {
            transferOwnership(_owner);
        }
    }

    function _baseURI() internal pure override returns (string memory) {
        return "https://clashcardschampions.infura-ipfs.io/ipfs/";
    }

    function safeMint(address to) external onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        listTokens.push(tokenId);
        dayAttributes[tokenId] = DayAttribute(TimeType.MORNING, block.timestamp);
    }

    function tokenURI(uint256 _tokenId)
        public
        view
        override
        returns (string memory)
    {
        _requireMinted(_tokenId);
        string memory base = _baseURI();

        if (dayAttributes[_tokenId].timeType == TimeType.MORNING) {
            return string(abi.encodePacked(base, MORNING));
        } else if (dayAttributes[_tokenId].timeType == TimeType.AFTERMOON) {
            return string(abi.encodePacked(base, AFTERMOON));
        } else {
            return string(abi.encodePacked(base, NIGHT));
        }
    }

    function checkUpkeep(
        bytes calldata /* checkData */
    )
        external
        view
        override
        returns (
            bool upkeepNeeded,
            bytes memory performData
        )
    {
        if (!isOn) {
            return (false, "");
        }
        for (uint256 i = 0; i < listTokens.length; i++) {
            uint256 tokenId = listTokens[i];
            if((block.timestamp - dayAttributes[tokenId].lastChange) > interval) {
                return (true, "");
            }
        }
        return (false, "");
    }

    function performUpkeep(
        bytes calldata /* performData */
    ) external override {
        if (isOn) {
            for (uint256 i = 0; i < listTokens.length; i++) {
                uint256 tokenId = listTokens[i];
                if (
                    (block.timestamp - dayAttributes[tokenId].lastChange) >
                    interval
                ) {
                    updateToken(tokenId);
                }
            }
        }
    }

    function setVariables(uint256 _interval, bool _status) external onlyOwner {
        interval = _interval;
        isOn = _status;
    }

    function updateToken(uint256 tokenId) private {
        if (dayAttributes[tokenId].timeType == TimeType.NIGHT) {
            dayAttributes[tokenId].timeType = TimeType.MORNING;
        } else {
            dayAttributes[tokenId].timeType = TimeType(uint8(dayAttributes[tokenId].timeType) + uint8(1));
        }
        dayAttributes[tokenId].lastChange = block.timestamp;
    }
}
