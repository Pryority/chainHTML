// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import "solady-utils/LibString.sol";
import {HTML} from "../src/HTML.sol";

contract HTMLTest is Test {
    HTML.Element public element;
    HTML.Tag public tag;

    function setUp() public {
        tag = HTML.Tag.div;
        element = HTML.Element(
            tag,
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
        assertEq(HTML.getTag(tag), parsedTag);
        assertEq(
            "color: white; background-color: #1e1e1e; font-size: 18px;",
            parsedStyle
        );
        assertEq("Hello, World!", parsedContent);

        emit log_named_string("COMPONENT", renderedHTML);
    }

    // TODO: Add check for href attribute if tag is 'a'
    function test_CreateUnstyledAnchorThenStyle() public {
        HTML.Element memory el = HTML.Element(
            HTML.Tag.a,
            "",
            "I am an unstyled anchor"
        );

        string memory renderedUnstyledHTML = HTML.render(el);

        (
            string memory parsedTag,
            string memory parsedStyle,
            string memory parsedContent
        ) = parseRendered(renderedUnstyledHTML);

        assertEq(parsedTag, "a");
        assertEq(parsedStyle, "");
        assertEq(parsedContent, "I am an unstyled anchor");

        emit log_named_string("UNSTYLED", renderedUnstyledHTML);

        string memory renderedStyledHTML = HTML.style(
            el,
            "background-color: #1e1e1e;"
        );

        string memory renderedStyledUpdatedHTML = HTML.updateContent(
            el,
            "I am a styled anchor"
        );

        (
            string memory newParsedTag,
            string memory newParsedStyle,
            string memory newParsedContent
        ) = parseRendered(renderedStyledUpdatedHTML);

        assertEq(newParsedTag, "a");
        assertEq(newParsedStyle, "background-color: #1e1e1e;");
        assertEq(newParsedContent, "I am a styled anchor");

        emit log_named_string("STYLED", renderedStyledUpdatedHTML);
    }

    /** Creates a button HTML element with an empty style. */
    function test_CreateUnstyledButton() public {
        HTML.Element memory el = HTML.Element(
            HTML.Tag.button,
            "",
            "I am an unstyled button"
        );

        string memory renderedUnstyledHTML = HTML.render(el);

        (
            string memory parsedTag,
            string memory parsedStyle,
            string memory parsedContent
        ) = parseRendered(renderedUnstyledHTML);

        assertEq(parsedTag, "button");
        assertEq(parsedStyle, "");
        assertEq(parsedContent, "I am an unstyled button");

        emit log_named_string("UNSTYLED", renderedUnstyledHTML);
    }

    /**
     * @notice Parses the rendered HTML to extract tag, style, and content.
     * @param html The rendered HTML string to be parsed.
     * @return rTag The tag from the rendered HTML.
     * @return rStyle The style from the rendered HTML.
     * @return rContent The content from the rendered HTML.
     */
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
        emit log_named_string("TAG", rTag);

        // Extract the style
        uint256 startStyle = LibString.indexOf(html, 'style="', endTag + 1);
        // emit log_named_uint("START STYLE", startStyle);
        if (startStyle != type(uint256).max) {
            // Case: Style attribute is present
            startStyle += 7; // Move the start index to the beginning of the style value
            uint256 endStyle = LibString.indexOf(html, '"', startStyle + 1);
            if (endStyle != type(uint256).max) {
                // Case: End of style found
                rStyle = LibString.slice(html, startStyle, endStyle);
                emit log_named_string("STYLE", rStyle);
            } else {
                // Case: End of style not found, set rStyle to empty string
                rStyle = "";
                emit log_named_string("STYLE", rStyle);
            }
        } else {
            // Case: Style attribute is not present
            rStyle = "";
            emit log_named_string("STYLE", rStyle);
        }

        // Extract the content
        uint256 startContent = LibString.indexOf(html, ">", 0) + 1;
        uint256 endContent = LibString.indexOf(html, "<", startContent + 1);
        rContent = LibString.slice(html, startContent, endContent);
        emit log_named_string("CONTENT", rContent);
    }

    // function testFuzz_Render(string memory _tag) public {
    //     string memory blank = "";
    //     vm.assume(!LibString.eq(_tag, blank));
    //     // Convert the input tag to lowercase
    //     tag = stringToTag(_tag);

    //     // Set the HTML element tag to the fuzzed tag
    //     element.tag = tagToString(tag);

    //     string memory renderedHTML = HTML.render(element);

    //     // Parse the renderedHTML
    //     (
    //         string memory parsedTag,
    //         string memory parsedStyle,
    //         string memory parsedContent
    //     ) = parseRendered(renderedHTML);

    //     // Assert the values
    //     assertEq(_tag, parsedTag);
    //     assertEq(
    //         "color: white; background-color: #1e1e1e; font-size: 18px;",
    //         parsedStyle
    //     );
    //     assertEq("Hello, World!", parsedContent);

    //     emit log_named_string("COMPONENT", renderedHTML);
    // }

    // function tagToString(HTML.Tag _tag) internal pure returns (string memory) {
    //     if (_tag == HTML.Tag.div) {
    //         return "div";
    //     } else if (_tag == HTML.Tag.button) {
    //         return "button";
    //     } else if (_tag == HTML.Tag.a) {
    //         return "a";
    //     }
    //     // Add more mappings as needed for other enum values

    //     revert("Invalid tag");
    // }
}
