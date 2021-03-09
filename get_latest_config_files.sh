BASELINK="https://hydra.iohk.io/job/Cardano/iohk-nix/cardano-deployment/latest-finished/download/1/"


cd cardano_node_setup
sh sever-setup.sh



# Shelley Testnet
#echo "Downloading shelley_testnet files..."
#curl -sSL ${BASELINK}testnet-config.json -o config/config.json
#curl -sSL ${BASELINK}testnet-shelley-genesis.json -o config/testnet-shelley-genesis.json
#curl -sSL ${BASELINK}testnet-byron-genesis.json -o config/testnet-byron-genesis.json
#curl -sSL ${BASELINK}testnet-topology.json -o config/topology.json

## Testnet
#wget https://hydra.iohk.io/job/Cardano/cardano-node/cardano-deployment/latest-finished/download/1/testnet-config.json -O ../config.json
#wget https://hydra.iohk.io/job/Cardano/cardano-node/cardano-deployment/latest-finished/download/1/testnet-byron-genesis.json -O ../testnet-byron-genesis.json
#wget https://hydra.iohk.io/job/Cardano/cardano-node/cardano-deployment/latest-finished/download/1/testnet-shelley-genesis.json -O ../testnet-shelley-genesis.json
#wget https://hydra.iohk.io/job/Cardano/cardano-node/cardano-deployment/latest-finished/download/1/testnet-topology.json -O ../topology.json





# # Mainnet
echo "Downloading mainnet files..."
wget https://hydra.iohk.io/job/Cardano/cardano-node/cardano-deployment/latest-finished/download/1/mainnet-config.json -O /cardano/config/config.json
wget https://hydra.iohk.io/job/Cardano/cardano-node/cardano-deployment/latest-finished/download/1/mainnet-byron-genesis.json -O /cardano/config/mainnet-byron-genesis.json
wget https://hydra.iohk.io/job/Cardano/cardano-node/cardano-deployment/latest-finished/download/1/mainnet-shelley-genesis.json -O /cardano/config/mainnet-shelley-genesis.json
wget https://hydra.iohk.io/job/Cardano/cardano-node/cardano-deployment/latest-finished/download/1/mainnet-topology.json -O /cardano/config/topology.json



