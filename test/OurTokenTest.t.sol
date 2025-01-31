// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployOurToken} from "../script/DeployOurToken.s.sol";
import {OurToken} from "../src/OurToken.sol";

contract OurTokenTest is Test {
    OurToken public ourToken;
    DeployOurToken public deployer;

    address bob = makeAddr("bob");
    address alice = makeAddr("alice");

    uint256 public constant STARTING_BALANCE = 100 ether;

    function setUp() public {
        deployer = new DeployOurToken();
        ourToken = deployer.run();

        vm.prank(msg.sender);
        ourToken.transfer(bob, STARTING_BALANCE);
    }

    function testBobBalance() public {
        assertEq(ourToken.balanceOf(bob), STARTING_BALANCE);
    }

    function testAllowances() public {
        uint256 initialAllowance = 1000;

        vm.prank(bob);
        ourToken.approve(alice, initialAllowance);

        uint256 transferAmount = 500;

        vm.prank(alice);
        ourToken.transferFrom(bob, alice, transferAmount);

        assertEq(ourToken.balanceOf(alice), transferAmount);
        assertEq(ourToken.balanceOf(bob), STARTING_BALANCE - transferAmount);
    }

    function testTransfer() public {
        uint256 transferAmount = 50;

        vm.prank(bob);
        ourToken.transfer(alice, transferAmount);

        assertEq(ourToken.balanceOf(alice), transferAmount);
        assertEq(ourToken.balanceOf(bob), STARTING_BALANCE - transferAmount);
    }

    function testBalanceAfterTransfer() public {
        uint256 transferAmount = 50;

        vm.prank(bob);
        ourToken.transfer(alice, transferAmount);

        assertEq(ourToken.balanceOf(bob), STARTING_BALANCE - transferAmount);
    }

    function testTransferFrom() public {
        uint256 initialAllowance = 1000;

        vm.prank(bob);
        ourToken.approve(alice, initialAllowance);

        uint256 transferAmount = 500;

        vm.prank(alice);
        ourToken.transferFrom(bob, alice, transferAmount);

        assertEq(ourToken.balanceOf(alice), transferAmount);
        assertEq(ourToken.balanceOf(bob), STARTING_BALANCE - transferAmount);
    }

    function testTransferExceedingBalance() public {
        vm.expectRevert();
        vm.prank(bob);
        ourToken.transfer(alice, STARTING_BALANCE + 1);
    }

    function testApproveAndTransferExceedingAllowance() public {
        vm.prank(bob);
        ourToken.approve(alice, 1000);

        vm.expectRevert();
        vm.prank(alice);
        ourToken.transferFrom(bob, alice, 2000);
    }

    function testTransferZeroAmount() public {
        vm.prank(bob);
        ourToken.transfer(alice, 0);
        assertEq(ourToken.balanceOf(alice), 0);
    }

    function testDecreaseAllowance() public {
        vm.prank(bob);
        ourToken.approve(alice, 1000);

        vm.prank(bob);
        ourToken.approve(alice, 500);

        assertEq(ourToken.allowance(bob, alice), 500);
    }

    function testTransferFromWithoutApproval() public {
        vm.expectRevert();
        vm.prank(alice);
        ourToken.transferFrom(bob, alice, 500);
    }
}
