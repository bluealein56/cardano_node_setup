#!/bin/bash
# This script sets up the node for use as a stake pool.

trap 'echo "$BASH_COMMAND"' DEBUG

# Login as root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo "This script was developed on Debian Linux 10"
echo "You are running the following version of Linux:"
head -1 /etc/os-release

# Update and install needed packages
apt update
apt -y upgrade
apt -y install git tmux ufw htop chrony curl rsync

# Download and install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
rm get-docker.sh
echo "The following version of Docker has been installed:"
docker --version

# Add the current user to the docker group
echo "Adding user \"`whoami`\" to the docker group"
groupadd docker
usermod -aG docker `whoami`

# Pull the cardano-node docker container
#docker pull registry.gitlab.com/viper-staking/docker-containers/cardano-node:latest
#docker login
docker pull bluealein56/ehm-node:latest


# Create the lovelace user (do not switch user)
groupadd -g 1024 lovelace
useradd -m -u 1000 -g lovelace -s /bin/bash lovelace
usermod -aG sudo lovelace
usermod -aG docker lovelace
passwd lovelace

# Create the directories for the node
mkdir /home/lovelace/cardano-node
mkdir /home/lovelace/cardano-node/db
touch /home/lovelace/cardano-node/node.socket
chown -R lovelace:lovelace /home/lovelace/cardano-node
chmod -R 774 /home/lovelace/cardano-node

# Configure chrony (use the Google time server)
cat > /etc/chrony/chrony.conf << EOM
server time.google.com prefer iburst minpoll 4 maxpoll 4
keyfile /etc/chrony/chrony.keys
driftfile /var/lib/chrony/chrony.drift
maxupdateskew 5.0
rtcsync
makestep 0.1 -1
leapsectz right/UTC
local stratum 10
EOM
timedatectl set-timezone UTC
systemctl stop systemd-timesyncd
systemctl disable systemd-timesyncd
systemctl restart chrony
hwclock -w

# Setup the Swap File
fallocate -l 2G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
cp /etc/fstab /etc/fstab.back
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

# Setup SSH
cp -r ~/.ssh /home/lovelace
chown -R lovelace:lovelace /home/lovelace/.ssh
sed -i.bak1 's/#Port 22/Port 2222/g' /etc/ssh/sshd_config
sed -i.bak2 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
echo 'AllowUsers lovelace' >> /etc/ssh/sshd_config
systemctl restart ssh

# Setup the firewall
ufw allow 2222/tcp  # ssh port
ufw allow 3001/tcp  # cardano-node port / RTView port
ufw allow 3000/tcp  # cardano-node port / RTView port
ufw allow 9100/tcp  # prometheus port
ufw allow 12798/tcp # prometheus port
ufw allow 80/http # RTView port
ufw allow 443/https # RTView port
ufw enable

# Reboot
shutdown -r 0                                                                                                                                                                                                                         87        87,14         Bot