// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

library HTML {
    struct Element {
        string tag;
        string style;
        string content;
    }

    // struct Element {
    //     bytes4 tag;
    //     bytes4 style;
    //     bytes24 content;
    // }

    function render(Element memory $) internal pure returns (string memory) {
        return
            string(
                abi.encodePacked(
                    "<",
                    $.tag,
                    ' style="',
                    $.style,
                    '">',
                    $.content,
                    "</",
                    $.tag,
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

    // function style(
    //     Element memory element,
    //     bytes4 newStyle
    // ) internal pure returns (string memory) {
    //     element.style = element.style | newStyle;
    //     return render(element);
    // }
}
