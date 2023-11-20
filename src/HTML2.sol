// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "solady-utils/LibString.sol";

library HTML2 {
    /* COMMON */
    // A generic element, can be used to construct any SVG (or HTML) element
    function el(
        string memory _tag,
        string memory _props,
        string memory _children
    ) internal pure returns (string memory) {
        return
            string.concat(
                "<",
                _tag,
                " ",
                _props,
                ">",
                _children,
                "</",
                _tag,
                ">"
            );
    }

    // A generic element, can be used to construct any SVG (or HTML) element without children
    function el(
        string memory _tag,
        string memory _props
    ) internal pure returns (string memory) {
        return string.concat("<", _tag, " ", _props, "/>");
    }

    function prop(
        string memory _key,
        string memory _val
    ) internal pure returns (string memory) {
        return string.concat(_key, "=", '"', _val, '" ');
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
