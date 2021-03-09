BASELINK="https://hydra.iohk.io/job/Cardano/iohk-nix/cardano-deployment/latest-finished/download/1/"

cd /cardano/config
sudo mkdir ./mainnet
sudo chmod 777 ./mainnet
sudo mkdir ./testnet
sudo chmod 777 ./testnet

## Testnet
echo "Downloading Tesnet files..."
wget https://hydra.iohk.io/job/Cardano/cardano-node/cardano-deployment/latest-finished/download/1/testnet-config.json -O /cardano/config/testnet/config.json
wget https://hydra.iohk.io/job/Cardano/cardano-node/cardano-deployment/latest-finished/download/1/testnet-byron-genesis.json -O /cardano/config/testnet/testnet-byron-genesis.json
wget https://hydra.iohk.io/job/Cardano/cardano-node/cardano-deployment/latest-finished/download/1/testnet-shelley-genesis.json -O /cardano/config/testnet/testnet-shelley-genesis.json
wget https://hydra.iohk.io/job/Cardano/cardano-node/cardano-deployment/latest-finished/download/1/testnet-topology.json -O /cardano/config/testnet/topology.json

# # Mainnet
echo "Downloading Mainet files..."
wget https://hydra.iohk.io/job/Cardano/cardano-node/cardano-deployment/latest-finished/download/1/mainnet-config.json -O /cardano/config/mainnet/config.json
wget https://hydra.iohk.io/job/Cardano/cardano-node/cardano-deployment/latest-finished/download/1/mainnet-byron-genesis.json -O /cardano/config/mainnet/mainnet-byron-genesis.json
wget https://hydra.iohk.io/job/Cardano/cardano-node/cardano-deployment/latest-finished/download/1/mainnet-shelley-genesis.json -O /cardano/config/mainnet/mainnet-shelley-genesis.json
wget https://hydra.iohk.io/job/Cardano/cardano-node/cardano-deployment/latest-finished/download/1/mainnet-topology.json -O /cardano/config/mainnet/topology.json



