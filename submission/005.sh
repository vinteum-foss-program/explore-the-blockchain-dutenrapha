#!/bin/bash
txid="37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517"
transaction=$(bitcoin-cli getrawtransaction "$txid" true)
pubkeys=$(echo "$transaction" | jq -r '.vin[].txinwitness[-1]' | grep -oE '[0-9a-f]{66,130}' | head -n 4)
pubkeys_array=$(echo "$pubkeys" | jq -nR '[inputs]')
multisig=$(bitcoin-cli createmultisig 1 "$pubkeys_array")
echo $(echo "$multisig" | jq -r '.address')