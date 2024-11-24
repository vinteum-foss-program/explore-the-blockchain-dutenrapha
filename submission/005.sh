#!/bin/bash
txid="37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517"
transaction=$(bitcoin-cli getrawtransaction "$txid" true)
if [ -z "$transaction" ]; then
    echo "Error: Unable to fetch transaction details. Check the txid or Bitcoin node configuration."
    exit 1
fi
pubkeys=$(echo "$transaction" | jq -r '.vin[].txinwitness[-1]' | grep -oE '[0-9a-f]{66,130}' | head -n 4)
if [ $(echo "$pubkeys" | wc -l) -ne 4 ]; then
    echo "Error: Could not find 4 public keys in the transaction inputs."
    exit 1
fi
pubkeys_array=$(echo "$pubkeys" | jq -R '[inputs]')
multisig=$(bitcoin-cli createmultisig 1 "$pubkeys_array")
if [ -z "$multisig" ]; then
    echo "Error: Failed to create the multisig address."
    exit 1
fi
echo $(echo "$multisig" | jq -r '.address')
