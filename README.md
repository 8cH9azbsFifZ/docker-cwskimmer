Run the famous CW Skimmer under docker, using wine and novnc for remote access.

![CW Skimmer](doc/example_working.png)

## Features
+ Skimmer Server
+ CWSL 
+ CWSL_DIGI
+ RBN Aggregator
+ PSK Reporter

![Overview](doc/cwskimmer.drawio.png)

# Quick start
+ `make build`
+ `make run`
+ `open http://127.0.0.1:7373`
+ Buy a license from: http://www.dxatlas.com/cwskimmer/ and enter the license key in CW Skimmer.

Debugging:  
+ `docker pull ghcr.io/8ch9azbsfifz/docker-cwskimmer:latest `
+ ```docker run --network host --rm -it ghcr.io/8ch9azbsfifz/docker-cwskimmer:latest  bash```

## Ports
+ 7373 - External noVNC


## Connecting to RTL SDR
![Connected to RTL SDR](doc/connected.png)

+ RTL SDR with hermes simulation can run in docker, too using: https://github.com/8cH9azbsFifZ/librtlsdr

## Using docker-compose
+ Create a personal access token for ghcr.io, in order to pull the images

# References
+ https://sm7iun.se/redpitaya/cwskimmer/
+ https://github.com/k3it/HermesIntf/releases/tag/v21.7.18
+ http://www.reversebeacon.net/pages/Aggregator+34
+ Hermes DLL by https://github.com/KV4TT/HermesIntf