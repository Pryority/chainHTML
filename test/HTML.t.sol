// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import "solady-utils/LibString.sol";
import {HTML} from "../src/HTML.sol";

contract HTMLTest is Test {
    HTML.Element public element;

    function setUp() public {
        element = HTML.Element(
            "div",
            "color: white; background-color: #1e1e1e; font-size: 18px;",
            "Hello, World!"
        );
    }

    function test_Render() public {
        string memory renderedHTML = HTML.render(element);
        // emit log_string(renderedHTML);

        // Parse the renderedHTML
        (
            string memory parsedTag,
            string memory parsedStyle,
            string memory parsedContent
        ) = parseRendered(renderedHTML);

        // Assert the values
        assertEq("div", parsedTag);
        assertEq(
            "color: white; background-color: #1e1e1e; font-size: 18px;",
            parsedStyle
        );
        assertEq("Hello, World!", parsedContent);
    }

    function parseRendered(
        string memory html
    )
        internal
        returns (
            string memory rTag,
            string memory rStyle,
            string memory rContent
        )
    {
        // Extract the tag
        uint256 startTag = LibString.indexOf(html, "<", 0) + 1;
        uint256 endTag = LibString.indexOf(html, " ", 0) - (startTag - 1);
        rTag = LibString.slice(html, startTag, endTag);
        emit log_string(rTag);

        // Extract the style
        uint256 startStyle = LibString.indexOf(html, 'style="', endTag + 1);
        if (startStyle != type(uint256).max) {
            startStyle += 7;
            uint256 endStyle = LibString.indexOf(html, '"', startStyle + 1);
            rStyle = LibString.slice(html, startStyle, endStyle);
            emit log_string(rStyle);
        }

        // Extract the content
        uint256 startContent = LibString.indexOf(html, ">", 0) + 1;
        uint256 endContent = LibString.indexOf(html, "<", startContent + 1);
        rContent = LibString.slice(html, startContent, endContent);
    }
}
