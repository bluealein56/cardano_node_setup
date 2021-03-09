#!/usr/bin/env bash

echo "Installing GIT"
sudo apt update
sudo echo y | apt install git
echo "Create Cardano Network"
sudo mkdir /cardano
sudo chmod 777 /cardano
cd /cardano/
echo "Clone Node Setup Repository"
git clone https://github.com/bluealein56/cardano_node_setup.git
