# ABI and Function Selectors

> **The ABI turns typed function calls into bytes; the first four bytes select the intended function.**

## The selector

For an external Solidity function, take the canonical signature with no spaces or return types:

```text
transfer(address,uint256)
```

Hash its UTF-8 bytes with Keccak-256 and keep the first four bytes:

```text
bytes4(keccak256("transfer(address,uint256)")) = 0xa9059cbb
```

Those four bytes begin calldata. Dispatcher bytecode compares them with known selectors and jumps to the matching function body.

## Argument encoding

After the selector, the ABI encodes arguments in 32-byte slots. Static values appear directly. Dynamic values such as strings and arrays use offsets pointing to later length-and-data sections.

The ABI also defines return values, custom errors, and event encoding. It is an application convention around raw EVM bytes, not a type system understood natively by the EVM.

## The ABI is not on-chain reflection

Deployed runtime bytecode does not normally contain a machine-readable JSON ABI. Block explorers obtain it from verified source metadata, project publishing, or reverse engineering.

Without the ABI, callers can still send bytes, but they may not know the intended names and types.

## Four bytes can collide

A selector has only 32 bits. Different function signatures can share the same first four hash bytes.

Compilers reject collisions within one normal contract interface, but proxy routing and custom dispatch code must account for them. A selector is not proof of caller intent, authorization, or safety.

```text
selector → how to route bytes
access check → whether the caller may perform the action
```

Never use “the calldata starts with this selector” as the only authorization rule when arbitrary forwarding or appended data can change context.

## Primary sources

- [Solidity Contract ABI Specification](https://docs.soliditylang.org/en/latest/abi-spec.html) — canonical signatures, selectors, static and dynamic encoding, return data, errors, and events.

## Check yourself

1. Which text is hashed to derive a function selector?
2. How many bytes long is the selector?
3. Where does a contract's human-readable JSON ABI usually come from?
4. Two function signatures share a selector and a proxy routes only by those four bytes. What has collided, and what security conclusion must the proxy avoid?

<!-- corepath:start -->

**Core Path 35/51** · [← EVM Data Areas](093-evm-data-areas.md) · [Smart Contract →](100-smart-contract.md)

<!-- corepath:end -->
