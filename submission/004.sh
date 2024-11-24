#!/bin/bash
xpub="xpub6Cx5tvq6nACSLJdra1A6WjqTo1SgeUZRFqsX5ysEtVBMwhCCRa4kfgFqaT2o1kwL3esB1PsYr3CUdfRZYfLHJunNWUABKftK2NjHUtzDms2"
descriptor=$(bitcoin-cli getdescriptorinfo "tr(${xpub}/100)" | jq -r '.descriptor')
taproot_address=$(bitcoin-cli deriveaddresses "$descriptor" | jq -r '.[0]')
echo $taproot_address
