# Running Rocket.Chat on Ubuntu 20.04lts with Docker

Raspberry Pi 4 (2GB or 4GB configuration) can run 64bit Ubutnu 20.04lts readily.   

And ubuntu has [made it straigthforward to download image and install the operating system](https://ubuntu.com/download/raspberry-pi).

Unfortunately, there is [a bug with existing arm64 snap](https://github.com/RocketChat/Rocket.Chat.Embedded.arm64/issues/1) that affects mongodb, and snaps cannot be used to install Rocket.Chat on 20.04lts at the moment.

Instead, you an readily use docker to install your server on 20.04lts arm64.  Following is the instructions.

First, you should familiarize yourself with docker if you don't know what it is.  Some [learning resources](https://docs.docker.com/get-started/) from docker. 

## Install docker on ubuntu 20.04lts

From the ubuntu user prompt:

```
sudo addgroup --system docker
sudo adduser $USER docker
newgrp docker
sudo snap install docker
```
This should complete docker installation and you can run it to verify:

```
docker --help
docker ps
```

## Install mongodb

Create a directory named `mongo`:

```
mkdir mongo
cd mongo
```

Then create a subdirectory to contain the database:

```
mkdir data
chmod 777 data
```

Create a docker network to connect Rocket.Chat and MongoDB:

```
docker network create database
```

You can verify that the bridge network has been created:

```
docker network ls
```

Next, create a docker-compose file named `docker-compose.yml` containing:

```
version: "2.4"
services:
  mongo:
    image: mongo:3.6.18-xenial
    container_name: mongodb3618
    command: --replSet "rs0" --wiredTigerCacheSizeGB 0.5 --smallfiles
    volumes:
    - ./data:/data/db
    networks:
      - database
networks:
  database:
    external: true
```

Now, you can start the mongodb instance running:

```
docker-compose up -d
```

Once it started, you can check the logs via:

```
docker logs monodb3618
```

## Initializing the replicaset

This operation must be done ONE TIME ONLY - after the mongodb instance has started.





