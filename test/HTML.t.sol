// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import "solady-utils/LibString.sol";
import {HTML} from "../src/HTML.sol";

contract HTMLTest is Test {
    HTML.HTMLEl public element;

    function setUp() public {
        element = HTML.HTMLEl(
            "div",
            "color: white; background-color: #1e1e1e; font-size: 18px;",
            "Hello, World!"
        );
    }

    function test_Render() public {
        string memory renderedHTML = HTML.render(element);
        emit log_string(renderedHTML);

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
        pure
        returns (
            string memory rTag,
            string memory rStyle,
            string memory rContent
        )
    {
        // Extract the tag
        uint256 startTag = indexOf(html, "<", 0) + 1;
        uint256 endTag = indexOf(html, ">", startTag + 1);
        rTag = slice(html, startTag, endTag);

        // Extract the style
        uint256 startStyle = indexOf(html, 'style="', endTag + 1) + 7;
        uint256 endStyle = indexOf(html, '"', startStyle + 1);
        rStyle = slice(html, startStyle, endStyle);

        // Extract the content
        uint256 startContent = endStyle + 2;
        uint256 endContent = indexOf(html, "<", startContent + 1);
        rContent = slice(html, startContent, endContent);
    }
}
