# Cardano-Node Setup ( EHM Stake Pool Setup )


-----------------------------------------------------------------------


Code lives below:
- EHM Gitub (Node Setup)
https://github.com/bluealein56/cardano_node_setup

- EHM Gitub (Docker Container)
https://github.com/bluealein56/cardano_docker_containers

-----------------------------------------------------------------------



# Cloud Hosting Service

#### Digital Ocean 
- Cloud Compute Hosting \
https://cloud.digitalocean.com/
#### Docker registry 
- Cloud Storage Docker Images repository \
https://hub.docker.com/repository/docker/bluealein56/
#### Git Hub - Cloud Source code repository
- Source/Build Code \
https://github.com/bluealein56/cardano_node_setup \
https://github.com/bluealein56/cardano_docker_containers \
#### GIST - (Pool Metadata)
JSON File: https://git.io/JqLuF \
GIT Link: https://gist.github.com/bluealein56/ba39100ec879762523442eab7185ed29





-----------------------------------------------------------------------

# Node Topology
##### 3 nodes, 1 reporting server

#### Worker Nodes:
ehm-relay01  --> Relay Node \
ehm-relay02 --> Relay Node \
ehm-bp --> Block Producing Node 

#### Reporting Node: 
ehm-rtview --> RealTimeViewer, Prometheus

-----------------------------------------------------------------------

# Setup Node

SSH to Cloud Server \
Example: ```ssh -i ./ehm_key root@167.71.163.136```

- Copy and Paste in cloud server terminal. Must be present to enter github credentials during install. 
``` 
sudo apt update 
sudo echo y | apt install git
sudo mkdir /cardano
sudo chmod 777 /cardano
cd /cardano/
sudo mkdir ./config
sudo chmod 777 ./config
git clone https://github.com/bluealein56/cardano_node_setup.git

cd /cardano/cardano_node_setup 
sh get_latest_config_files.sh
sh sever-setup.sh
```
 
-----------------------------------------------------------------------

# Edit Config Files

Example: ``` vim /cardano/config/mainnet/config.json```

- Block Producer Node
```
{
  "Producers": [
    {
      "addr": "167.71.163.136",
      "port": 3001,
      "valency": 1
    }
  ]
}
```

- Relay Node \
Input your Relay and Other network Relays on the internet.

```
{
  "Producers": [
    {
      "addr": ""relays-new.cardano-testnet.iohkdev.io"",
      "port": 3001,
      "valency": 2
    },
    {
      "addr": "167.71.163.136",
      "port": 3001,
      "valency": 1
    }
  ]
}

```

-----------------------------------------------------------------------

*** Start Container***

SSH back into cloud server with new username lovelace and specify ssh port 2222 \
Example: ``` ssh -i ./ehm_key lovelace@167.71.163.136 -p 2222 ``` 

#### Set Export Command for desired deployment environment

- Copy and Paste in cloud server terminal. 
##### - Mainnet
```
export CMD="docker run --mount type=bind,source=/cardano/config/mainnet,target=/home/lovelace/cardano-node/ -p 9100:9100 -p 12798:12798 -p 4444:4444 bluealein56/ehm-node:latest"
```

##### - Testnet
```
export CMD="docker run --mount type=bind,source=/cardano/config/testnet,target=/home/lovelace/cardano-node/ -p 9100:9100 -p 12798:12798 -p 4444:4444 bluealein56/ehm-node:latest"
```



#### Start Node 
```
/cardano/cardano_node_setup/run-cardano-node.sh "$CMD"
```


-----------------------------------------------------------------------

## Default configuration (cardano-node binary)
This container runs with `ENTRYPOINT cardano-node`. A `CMD` statement provides a
default argument if no arguments are provided when running the container. This 
will simply print the cardano-node version.

The following command will run the container in this configuration:
``` bash
docker run bluealein56/ehm-node:latest
```

## Alternate configuration (block producing node)
Below is an example on overriding the default CMD arguments to run cardano-node 
as a block producing node:
``` bash
docker run bluealein56/ehm-node:latestt \
    --database-path $HOME/cardano-node/db/ \
    --socket-path $HOME/cardano-node/db/node.socket \
    --host-addr "0.0.0.0" \
    --port 4444 \
    --config $HOME/cardano-node/config.json \
    --topology $HOME/cardano-node/topology.json \
    --shelley-kes-key $HOME/cardano-node/pool_kes.skey \
    --shelley-vrf-key $HOME/cardano-node/pool_vrf.skey
```

## Alternate configuration (relay node)
Below is an example on overriding the default CMD arguments to run cardano-node 
as a relay node:
``` bash
docker run bluealein56/ehm-node:latest \
    --database-path $HOME/cardano-node/db/ \
    --socket-path $HOME/cardano-node/db/node.socket \
    --port 4444 \
    --host-addr "0.0.0.0" \
    --config $HOME/cardano-node/config.json
```

## Alternate configuration (shell entrypoint)
Below is an example on overriding the entrypoint to enter the container in a 
shell. This configuration boots the container into a ZSH shell so that the user
can interact with the container and run any desired commands. Use this for
debugging:
``` bash
docker run -it --entrypoint /usr/bin/zsh bluealein56/ehm-node:latest
```

## Running with run-cardano-node script
The script `run-cardano-node.sh` is provided to simplify running the 
cardano-node either via the docker container or from a local installation. The 
first argument accepts a command prefix string which specifies where to execute cardano-node so it may be used with the container as:

### Docker execution
``` bash
export CMD="docker run --mount type=bind,source=$PWD/config,target=/home/lovelace/cardano-node/ -p 9100:9100 -p 12798:12798 bluealein56/ehm-node:latest"
./run-cardano-node.sh $CMD
```

The `run-cardano-node.sh` script assumes the location of the node configuration 
files and may need to be adjuster per your setup.

You can open a shell in the running container with the following command:
``` bash
docker exec -it <container_id> /usr/bin/zsh
```

You can get the ID of the running container by running `docker ps`.

### Local execution
Use this to run cardano-node from a local cardano installation (or to run 
cardano-node when inside the docker container via shell):
``` bash
export CMD="/usr/local/bin/cardano-node"
./run-cardano-node.sh $CMD
```

## Required files
* Node configuration files (latest files [here](https://hydra.iohk.io/job/Cardano/iohk-nix/cardano-deployment/latest-finished/download/1/index.html))
  * config.json
  * topology.json
  * genesis.json

These files are different depending on the network (e.g., testnet vs. mainnet)
and may be fetched automatically using the provided `get_latest_config_files.sh`
script.

## Monitor node with prometheus

0. Ensure the node has been updated to enable prometheus by adding the following
to the `config.json` file:

```
hasPrometheus:
   - "0.0.0.0"
   - 12798
```

1. Pull prometheus docker container from [Dockerhub](https://hub.docker.com/r/prom/prometheus):
``` bash
docker pull prom/prometheus
```

2. Get the IP address of the node you'd like to monitor. If using docker, you can get the IP with:
``` bash
docker network inspect bridge
```
3. Modify prometheus.yml and change `localhost` to the container's IP address
- On Monitoring Node, enter target node info
```
 scrape_configs:
   - job_name: 'ehm-bp' # To scrape data from the cardano node
     scrape_interval: 5s
     static_configs:
       - targets: ['142.93.79.51:12798']
```
4. Run the prometheus container:
``` bash
docker run \
    -p 9090:9090 \
    -v $PWD/prometheus.yml:/etc/prometheus/prometheus.yml \
    prom/prometheus
```
5. Access the prometheus web UI at `<container IP>:9090/graph`

---

#### Install Cardano RTView
 On monitoring node:
 ```
wget https://github.com/input-output-hk/cardano-rt-view/releases/download/0.3.0/cardano-rt-view-0.3.0-linux-x86_64.tar.gz
```
Unzip File
Example: ```sudo tar -xzf cardano-rt-view-0.3.0-linux-x86_64.tar.gz```