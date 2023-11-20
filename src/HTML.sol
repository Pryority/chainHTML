// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "solady-utils/LibString.sol";

library HTML {
    struct Element {
        Tag tag;
        string style;
        string content;
    }

    enum Tag {
        div,
        button,
        a
    }

    // TODO: Add check for href attribute if tag is 'a'
    function render(
        Element memory element
    ) internal pure returns (string memory) {
        return
            string(
                abi.encodePacked(
                    "<",
                    getTag(element.tag),
                    ' style="',
                    element.style,
                    '">',
                    element.content,
                    "</",
                    getTag(element.tag),
                    ">"
                )
            );
    }

    function updateContent(
        Element memory element,
        string memory _content
    ) internal pure returns (string memory) {
        return
            string(
                abi.encodePacked(
                    "<",
                    getTag(element.tag),
                    ' style="',
                    element.style,
                    '">',
                    _content,
                    "</",
                    getTag(element.tag),
                    ">"
                )
            );
    }

    function style(
        Element memory element,
        string memory _style
    ) internal pure returns (string memory) {
        element.style = _style;
        return render(element);
    }

    function getTag(HTML.Tag _tag) public pure returns (string memory) {
        if (_tag == HTML.Tag.div) {
            return "div";
        } else if (_tag == HTML.Tag.button) {
            return "button";
        } else if (_tag == HTML.Tag.a) {
            return "a";
        }
        return "div";
    }

    /**
     * @notice Parses the rendered HTML to extract tag, style, and content.
     * @param html The rendered HTML string to be parsed.
     * @return rTag The tag from the rendered HTML.
     * @return rStyle The style from the rendered HTML.
     * @return rContent The content from the rendered HTML.
     * @dev Note: This does not work properly when using other attributes like href, class, etc.
     */
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
        uint256 startTag = LibString.indexOf(html, "<", 0) + 1;
        uint256 endTag = LibString.indexOf(html, " ", 0) - (startTag - 1);
        rTag = LibString.slice(html, startTag, endTag);
        // emit log_named_string("TAG", rTag);

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
                // emit log_named_string("STYLE", rStyle);
            } else {
                // Case: End of style not found, set rStyle to empty string
                rStyle = "";
                // emit log_named_string("STYLE", rStyle);
            }
        } else {
            // Case: Style attribute is not present
            rStyle = "";
            // emit log_named_string("STYLE", rStyle);
        }

        // Extract the content
        uint256 startContent = LibString.indexOf(html, ">", 0) + 1;
        uint256 endContent = LibString.indexOf(html, "<", startContent + 1);
        rContent = LibString.slice(html, startContent, endContent);
        // emit log_named_string("CONTENT", rContent);
    }
}
