#!/bin/bash
hash=$(bitcoin-cli getblockhash 123456)
block=$(bitcoin-cli getblock $hash 2)
outputs=$(echo $block | jq '[.tx[].vout | length] | add')
echo $outputs
