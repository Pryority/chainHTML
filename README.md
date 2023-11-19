# chainHTML

**A WIP Solidity Library for building interactive HTML components onchain.**

Tested and Built with:

- **Foundry**: Ethereum development framework (Hardhat but in Solidity).

Inspired by [ilamanov](https://github.com/ilamanov)'s Research and Development with **[on-chain-ui](https://github.com/ilamanov/on-chain-ui/tree/main)**: Build and compose UI components on-chain.

## Documentation

### [Render Element](src/HTML.sol#L18)

```solidity
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
```

### [Update Content of Element](src/HTML.sol#L37)

```solidity
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
```

### [Add Style to Element](src/HTML.sol#L57)

```solidity
function style(
        Element memory element,
        string memory _style
    ) internal pure returns (string memory) {
        element.style = _style;
        return render(element);
    }
```

## Using Foundry to interact with chainHTML

### Build

```shell
forge build
```

### Test

```shell
forge test
```

### Format

```shell
forge fmt
```

### Gas Snapshots

```shell
forge snapshot
```

### Anvil

```shell
anvil
```

### Deploy

```shell
forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
cast <subcommand>
```

### Help

```shell
forge --help
anvil --help
cast --help
```
