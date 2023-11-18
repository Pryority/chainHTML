// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./HTML.sol";

interface IHTML {
    function render(
        HTML.Element memory $
    ) external pure returns (string memory);
}

contract UIWrapper is IHTML {
    constructor() {}

    function render(
        HTML.Element memory $
    ) external pure override returns (string memory) {
        return
            string(
                abi.encodePacked(
                    "<",
                    HTML.getTag($.tag),
                    ' style="',
                    $.style,
                    '">',
                    $.content,
                    "</",
                    HTML.getTag($.tag),
                    ">"
                )
            );
    }
}
