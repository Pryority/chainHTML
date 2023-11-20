// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {HTML2} from "../src/HTML2.sol";

contract HTMLTest is Test {
    function setUp() public {}

    function test_Render() public {
        string memory renderedEl = HTML2.el(
            "div",
            HTML2.prop(
                "style",
                "color: white; background-color: #1e1e1e; font-size: 18px;"
            ),
            "Hello, World!"
        );
        emit log_string(renderedEl);

        (
            string memory parsedTag,
            string memory parsedStyle,
            string memory parsedContent
        ) = HTML2.parseRendered(renderedEl);

        emit log_named_string("TAG", parsedTag);
        emit log_named_string("STYLE", parsedStyle);
        emit log_named_string("CONTENT", parsedContent);

        assertEq("div", parsedTag);
        assertEq(
            "color: white; background-color: #1e1e1e; font-size: 18px;",
            parsedStyle
        );
        assertEq("Hello, World!", parsedContent);

        emit log_named_string("COMPONENT", renderedEl);
    }
}
