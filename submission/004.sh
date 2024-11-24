#!/bin/bash

# Configuração inicial
xpub="xpub6Cx5tvq6nACSLJdra1A6WjqTo1SgeUZRFqsX5ysEtVBMwhCCRa4kfgFqaT2o1kwL3esB1PsYr3CUdfRZYfLHJunNWUABKftK2NjHUtzDms2"

# Criar um descritor para o caminho derivado
descriptor=$(bitcoin-cli getdescriptorinfo "tr(${xpub}/100)" | jq -r '.descriptor')

echo $descriptor
# Derivar o endereço Taproot
taproot_address=$(bitcoin-cli deriveaddresses "$descriptor" | jq -r '.[0]')


# Exibir o endereço derivado
echo $taproot_address
