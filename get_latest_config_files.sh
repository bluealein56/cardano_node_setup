BASELINK="https://hydra.iohk.io/job/Cardano/iohk-nix/cardano-deployment/latest-finished/download/1/"

# Shelley Testnet
#echo "Downloading shelley_testnet files..."
#curl -sSL ${BASELINK}testnet-config.json -o config/config.json
#curl -sSL ${BASELINK}testnet-shelley-genesis.json -o config/testnet-shelley-genesis.json
#curl -sSL ${BASELINK}testnet-byron-genesis.json -o config/testnet-byron-genesis.json
#curl -sSL ${BASELINK}testnet-topology.json -o config/topology.json

# Mainnet Candidate
#echo "Downloading mainnet_candidate files..."
#curl -sSL ${BASELINK}mainnet_candidate_4-config.json -o config/mainnet_candidate-config.json
#curl -sSL ${BASELINK}mainnet_candidate_4-shelley-genesis.json -o config/mainnet_candidate-shelley-genesis.json
#curl -sSL ${BASELINK}mainnet_candidate_4-byron-genesis.json -o config/mainnet_candidate-byron-genesis.json
#curl -sSL ${BASELINK}mainnet_candidate_4-topology.json -o config/mainnet_candidate-topology.json

# # Mainnet
echo "Downloading mainnet files..."
curl -sSL ${BASELINK}mainnet-config.json -o ../config.json
curl -sSL ${BASELINK}mainnet-shelley-genesis.json -o ../mainnet-shelley-genesis.json
curl -sSL ${BASELINK}mainnet-byron-genesis.json -o ../mainnet-byron-genesis.json
curl -sSL ${BASELINK}mainnet-topology.json -o ../topology.json
