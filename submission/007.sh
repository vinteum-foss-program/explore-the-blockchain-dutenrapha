#!/bin/bash
BLOCK_HASH=$(bitcoin-cli getblockhash 123321)

TXS=$(bitcoin-cli getblock "$BLOCK_HASH" | jq -r '.tx[]' 2>/dev/null)
LAST_UTXO_ADDRESS=""
for TX in $TXS; do
  RAW_TX=$(bitcoin-cli getrawtransaction "$TX" true 2>/dev/null)
  VOUTS=$(echo "$RAW_TX" | jq -c '.vout[]' 2>/dev/null)
  while IFS= read -r VOUT; do
    INDEX=$(echo "$VOUT" | jq -r '.n // empty')
    ADDRESS=$(echo "$VOUT" | jq -r '.scriptPubKey.address // empty')
    TXOUT=$(bitcoin-cli gettxout "$TX" "$INDEX" 2>/dev/null)

    if [ -n "$TXOUT" ] && [ "$TXOUT" != "null" ]; then
      LAST_UTXO_ADDRESS="$ADDRESS"
    fi
  done <<< "$VOUTS"
done

echo $LAST_UTXO_ADDRESS