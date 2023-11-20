// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
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

    function test_El() public {
        string memory renderedHTML = HTML.render(element);
        // emit log_string(renderedHTML);

        (
            string memory parsedTag,
            string memory parsedStyle,
            string memory parsedContent
        ) = HTML.parseRendered(renderedHTML);

        emit log_named_string("TAG", parsedTag);
        emit log_named_string("STYLE", parsedStyle);
        emit log_named_string("CONTENT", parsedContent);

        assertEq(HTML.getTag(tag), parsedTag);
        assertEq(
            "color: white; background-color: #1e1e1e; font-size: 18px;",
            parsedStyle
        );
        assertEq("Hello, World!", parsedContent);

        emit log_named_string("COMPONENT", renderedHTML);
    }

    function test_Render() public {
        string memory renderedHTML = HTML.render(element);
        // emit log_string(renderedHTML);

        (
            string memory parsedTag,
            string memory parsedStyle,
            string memory parsedContent
        ) = HTML.parseRendered(renderedHTML);

        emit log_named_string("TAG", parsedTag);
        emit log_named_string("STYLE", parsedStyle);
        emit log_named_string("CONTENT", parsedContent);

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
        ) = HTML.parseRendered(renderedUnstyledHTML);

        emit log_named_string("TAG", parsedTag);
        emit log_named_string("EMPTY STYLE", parsedStyle);
        emit log_named_string("CONTENT", parsedContent);

        assertEq(parsedTag, "a");
        assertEq(parsedStyle, "");
        assertEq(parsedContent, "I am an unstyled anchor");

        emit log_named_string("UNSTYLED", renderedUnstyledHTML);

        HTML.Element memory renderedStyledHTML = HTML.Element(
            HTML.Tag.a,
            "background-color: #1e1e1e;",
            "I am a styled anchor"
        );

        string memory renderedStyledUpdatedHTML = HTML.updateContent(
            renderedStyledHTML,
            "I am a styled anchor"
        );

        (
            string memory newParsedTag,
            string memory newParsedStyle,
            string memory newParsedContent
        ) = HTML.parseRendered(renderedStyledUpdatedHTML);

        emit log_named_string("TAG", newParsedTag);
        emit log_named_string("NEW STYLE", newParsedStyle);
        emit log_named_string("CONTENT", newParsedContent);

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
        ) = HTML.parseRendered(renderedUnstyledHTML);

        assertEq(parsedTag, "button");
        assertEq(parsedStyle, "");
        assertEq(parsedContent, "I am an unstyled button");

        emit log_named_string("UNSTYLED", renderedUnstyledHTML);
    }
}
