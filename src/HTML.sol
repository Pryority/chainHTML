// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

library HTML {
    struct HTMLEl {
        string tag;
        string style;
        string content;
    }

    // struct HTMLEl {
    //     bytes4 tag;
    //     bytes4 style;
    //     bytes24 content;
    // }

    function render(HTMLEl memory $) internal pure returns (string memory) {
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
        HTMLEl memory element,
        string memory _style
    ) internal pure returns (string memory) {
        element.style = _style;
        return render(element);
    }

    // function style(
    //     HTMLEl memory element,
    //     bytes4 newStyle
    // ) internal pure returns (string memory) {
    //     element.style = element.style | newStyle;
    //     return render(element);
    // }
}
