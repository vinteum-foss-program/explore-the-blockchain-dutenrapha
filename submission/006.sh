#!/bin/bash
block_256128_hash=$(bitcoin-cli getblockhash 256128)
block_256128=$(bitcoin-cli getblock $block_256128_hash)
coinbase_txid=$(echo $block_256128 | jq -r '.tx[0]')
raw_coinbase_tx=$(bitcoin-cli getrawtransaction $coinbase_txid)
decoded_coinbase_tx=$(bitcoin-cli decoderawtransaction $raw_coinbase_tx)
block_257343_hash=$(bitcoin-cli getblockhash 257343)
block_257343=$(bitcoin-cli getblock $block_257343_hash)
txs_in_block=$(echo $block_257343 | jq -r '.tx[]')
for tx in $txs_in_block; do
    raw_tx=$(bitcoin-cli getrawtransaction $tx)
    decoded_tx=$(bitcoin-cli decoderawtransaction $raw_tx)
    spender=$(echo $decoded_tx | jq --arg txid "$coinbase_txid" '.vin[] | select(.txid == $txid)')
    if [ -n "$spender" ]; then
        echo $tx
        break
    fi
done
