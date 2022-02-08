// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {DSTest} from "ds-test/test.sol";
import {Utilities} from "./utils/Utilities.sol";
import {console} from "./utils/Console.sol";
import {Vm} from "forge-std/Vm.sol";

contract SoulboundTest is DSTest {
    Vm internal immutable vm = Vm(HEVM_ADDRESS);

    Utilities internal utils;
    address payable[] internal users;

    uint256 tries;

    function setUp() public {
        utils = new Utilities();
        users = utils.createUsers(5);
    }

    event Part(string p);

    function testExample() public {
        console.log("test");
    }
}
