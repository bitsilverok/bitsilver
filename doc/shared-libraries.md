Shared Libraries
================

## bitsilverconsensus

The purpose of this library is to make the verification functionality that is critical to BitSilver's consensus available to other applications, e.g. to language bindings.

### API

The interface is defined in the C header `bitsilverconsensus.h` located in `src/script/bitsilverconsensus.h`.

#### Version

`bitsilverconsensus_version` returns an `unsigned int` with the API version *(currently `1`)*.

#### Script Validation

`bitsilverconsensus_verify_script` returns an `int` with the status of the verification. It will be `1` if the input script correctly spends the previous output `scriptPubKey`.

##### Parameters
- `const unsigned char *scriptPubKey` - The previous output script that encumbers spending.
- `unsigned int scriptPubKeyLen` - The number of bytes for the `scriptPubKey`.
- `const unsigned char *txTo` - The transaction with the input that is spending the previous output.
- `unsigned int txToLen` - The number of bytes for the `txTo`.
- `unsigned int nIn` - The index of the input in `txTo` that spends the `scriptPubKey`.
- `unsigned int flags` - The script validation flags *(see below)*.
- `bitsilverconsensus_error* err` - Will have the error/success code for the operation *(see below)*.

##### Script Flags
- `bitsilverconsensus_SCRIPT_FLAGS_VERIFY_NONE`
- `bitsilverconsensus_SCRIPT_FLAGS_VERIFY_P2SH` - Evaluate P2SH ([BIP16](https://github.com/bitsilver/bips/blob/master/bip-0016.mediawiki)) subscripts
- `bitsilverconsensus_SCRIPT_FLAGS_VERIFY_DERSIG` - Enforce strict DER ([BIP66](https://github.com/bitsilver/bips/blob/master/bip-0066.mediawiki)) compliance
- `bitsilverconsensus_SCRIPT_FLAGS_VERIFY_NULLDUMMY` - Enforce NULLDUMMY ([BIP147](https://github.com/bitsilver/bips/blob/master/bip-0147.mediawiki))
- `bitsilverconsensus_SCRIPT_FLAGS_VERIFY_CHECKLOCKTIMEVERIFY` - Enable CHECKLOCKTIMEVERIFY ([BIP65](https://github.com/bitsilver/bips/blob/master/bip-0065.mediawiki))
- `bitsilverconsensus_SCRIPT_FLAGS_VERIFY_CHECKSEQUENCEVERIFY` - Enable CHECKSEQUENCEVERIFY ([BIP112](https://github.com/bitsilver/bips/blob/master/bip-0112.mediawiki))
- `bitsilverconsensus_SCRIPT_FLAGS_VERIFY_WITNESS` - Enable WITNESS ([BIP141](https://github.com/bitsilver/bips/blob/master/bip-0141.mediawiki))

##### Errors
- `bitsilverconsensus_ERR_OK` - No errors with input parameters *(see the return value of `bitsilverconsensus_verify_script` for the verification status)*
- `bitsilverconsensus_ERR_TX_INDEX` - An invalid index for `txTo`
- `bitsilverconsensus_ERR_TX_SIZE_MISMATCH` - `txToLen` did not match with the size of `txTo`
- `bitsilverconsensus_ERR_DESERIALIZE` - An error deserializing `txTo`
- `bitsilverconsensus_ERR_AMOUNT_REQUIRED` - Input amount is required if WITNESS is used

### Example Implementations
- [NBitSilver](https://github.com/NicolasDorier/NBitSilver/blob/master/NBitSilver/Script.cs#L814) (.NET Bindings)
- [node-libbitsilverconsensus](https://github.com/bitpay/node-libbitsilverconsensus) (Node.js Bindings)
- [java-libbitsilverconsensus](https://github.com/dexX7/java-libbitsilverconsensus) (Java Bindings)
- [bitsilverconsensus-php](https://github.com/Bit-Wasp/bitsilverconsensus-php) (PHP Bindings)
