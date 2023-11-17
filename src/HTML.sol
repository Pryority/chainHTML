// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

library HTML {
    struct Strings {
        string[] parts;
    }

    struct Bytes {
        bytes[] parts;
    }

    function initializeStrings() internal pure returns (Strings memory) {
        return Strings(new string[](0));
    }

    function initializeBytes() internal pure returns (Bytes memory) {
        return Bytes(new bytes[](0));
    }

    function joinStrings(
        Strings storage content,
        string memory stringToAdd
    ) internal {
        content.parts.push(stringToAdd);
    }

    function concatBytes(
        Bytes storage content,
        bytes memory bytesToAdd
    ) internal {
        content.parts.push(bytesToAdd);
    }

    function concatFromStrings(
        Strings memory content
    ) internal pure returns (string memory) {
        return string(abi.encodePacked(content.parts));
    }
}
