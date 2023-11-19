// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

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
}
