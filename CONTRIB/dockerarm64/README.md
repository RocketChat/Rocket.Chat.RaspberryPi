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
docker logs mongodb3618
```

## Initializing the replicaset

This operation must be done ONE TIME ONLY - after the mongodb instance has started.

```
docker exec -it mongodb3618 /bin/sh
```

You should get a `#` prompt running INSIDE the container.  Then connect to mongo:

```
mongo
```

Now you're using the mongodb client inside the container and you can initiate the replicatset:

```
rs.initiate() 
```

You should get a success message with a JSON return.  And also the prompt should change from `SECONDARY>` to `PRIMARY>`

Your replicaset is now initiated and ready for Rocket.Chat connections.

##  Starting Rocket.Chat server

Create another directory, at the same level as `mongo`,  named `rocketchat`.

```
mkdir rocketchat
cd rocketchat
```

Create a docker-compose file named `docker-compose.yml` containing:

```
version: "2.4"
services:
  rocketchat:
    image: singli/rocketchat:arm64-3.2.2
    container_name: rocketchat
    environment:
    - ROOT_URL=https://localhost:3000
    - MONGO_OPLOG_URL=mongodb://mongo:27017/local
    - MONGO_URL=mongodb://mongo:27017/rcdata
    ports:
    - "3000:3000"
    networks:
    - database
networks:
  database:
    external: true
```

Note that this pulls from my docker hub repository:  `singli/rocketchat:arm64-3.2.2`.   You may want to create your own docker image.  The source code [is here](https://github.com/RocketChat/Rocket.Chat.Embedded.arm64).

Next, you can start the rocket.chat server via:

```
docker-compose up -d
```

It takes up to a couple of minutes for the server to fully start.   You should look for a message in the log:

```
docker logs rocketchat
```

The success message is similar to:

```
➔ +-----------------------------------------------+
➔ |                 SERVER RUNNING                |
➔ +-----------------------------------------------+
➔ |                                               |
➔ |  Rocket.Chat Version: 3.2.2                   |
➔ |       NodeJS Version: 12.16.1 - arm64         |
➔ |      MongoDB Version: 3.6.18                  |
➔ |       MongoDB Engine: wiredTiger              |
➔ |             Platform: linux                   |
➔ |         Process Port: 3000                    |
➔ |             Site URL: https://localhost:3000  |
➔ |     ReplicaSet OpLog: Enabled                 |
➔ |          Commit Hash: a720d25f4e              |
➔ |        Commit Branch: HEAD                    |
➔ |                                               |
➔ +-----------------------------------------------+
```
 
That's it, your server is now up and running on port 3000.  You can consult [our main READ.ME](https://github.com/RocketChat/Rocket.Chat.RaspberryPi/blob/master/README.md#thats-it-your-private-chat-server-should-now-be-live)  and continue your experimentation.

Be sure to take some time to [learn docker and docker-compose](https://docs.docker.com/compose/gettingstarted/) in order to better control he lifecycle and maintenace of your Rocket.Chat and mongodb servers.

