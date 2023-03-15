// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract HelloWorld {

    string public helloWorld;

    constructor(string memory _helloWorld){
        helloWorld = _helloWorld;
    }

    function getHelloWorld() public view returns (string memory _helloWorld) {
        return helloWorld;
    }

    function setHelloWorld(string memory _helloWorld) public {
        helloWorld = _helloWorld;
    }
}