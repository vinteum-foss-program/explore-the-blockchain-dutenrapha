#!/bin/bash
TXID="e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163"
RAW_TX=$(bitcoin-cli getrawtransaction $TXID true)
TXIN_WITNESS=$(echo $RAW_TX | jq -r '.vin[0].txinwitness[2]')
PUBKEY=$(echo $TXIN_WITNESS | cut -c 3-68)
echo $PUBKEY
