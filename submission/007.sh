hash=$(bitcoin-cli getblockhash 123321)
block=$(bitcoin-cli getblock $hash 2)
unspent=$(echo $block | jq '.tx[].vout[] | select(.scriptPubKey.type == "pubkeyhash") | .scriptPubKey.addresses[0]')
echo $unspent
