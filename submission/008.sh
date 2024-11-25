#!/bin/bash
TXID="e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163"
RAW_TX=$(bitcoin-cli getrawtransaction $TXID 2>/dev/null)
DECODED_TX=$(bitcoin-cli decoderawtransaction $RAW_TX 2>/dev/null)
TXIN_WITNESS=$(echo "$DECODED_TX" | jq -r '.vin[0].txinwitness | @csv')
TXIN_WITNESS_ARRAY=($(echo $TXIN_WITNESS | tr ',' '\n' | sed 's/"//g'))
SIGNATURE=${TXIN_WITNESS_ARRAY[0]}
PUBKEY_OR_SCRIPT=${TXIN_WITNESS_ARRAY[-1]}
if [[ "$PUBKEY_OR_SCRIPT" =~ ^[0-9a-fA-F]{66}$ || "$PUBKEY_OR_SCRIPT" =~ ^[0-9a-fA-F]{130}$ ]]; then
  echo $PUBKEY_OR_SCRIPT
else
  FIRST_PUBKEY=$(echo "$PUBKEY_OR_SCRIPT" | grep -oE '21[0-9a-fA-F]{66}' | head -n 1 | cut -c 3-)
  echo $FIRST_PUBKEY
fi

exit 0
