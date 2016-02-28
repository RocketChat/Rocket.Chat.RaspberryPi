#!/bin/sh
# This script is a part of
# DeployPlaform - Deploy self-hosted apps efficiently
# that is distributed under the MIT License
# https://github.com/j8r/DPlatform
# Copyright (c) 2015-2016 Julien Reichardt - MIT License (MIT)

# Detect IP
IPv4=$(wget -qO- ipv4.icanhazip.com)
IPv6=$(ip addr show | sed -e's/^.*inet6 \([^ ]*\)\/.*$/\1/;t;d' | tail -n 2 | head -n 1)
# Set default IP to IPv4 unless IPv6 is available
[ $IPv6 = ::1 ] && IP=$IPv4 || IP=[$IPv6]
LOCALIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
DOMAIN=$(hostname)

# Detect package manager
if hash apt-get 2>/dev/null
	then PKG=deb
	install="debconf-apt-progress -- apt-get install -y"
	remove="apt-get purge -y"
elif hash rpm 2>/dev/null
	then PKG=rpm
	install="yum install --enablerepo=epel -y"
	remove="yum remove -y"
else
	whiptail --msgbox "Your OS isn't supported" 8 48 exit 1
fi

# Detect distribution
if grep 'Ubuntu' /etc/issue 2>/dev/null
	then DIST=ubuntu
fi

# Detect architecture
ARCH=$(uname -m)
case "$ARCH" in
	x86_64 | amd64) ARCH=amd64;;
	i*86) ARCH=86;;
	armv6) ARCH=armv6;;
	arm*) ARCH=arm;;
	*) whiptail --msgbox "Your architecture $ARCH isn't supported" 8 48 exit 1;;
esac

# Detect hardware
HDWR=$(uname -a)
case "$HDWR" in
	*rpi2*) HDWR=rpi2;;
	*rpi*) HDWR=rpi;;
	*bananian*) HDWR=bpi;;
	*) HDWR=other;;
esac

if hash mongo 2>/dev/null
then
  # Check MongoDB version
  mongo_ver=$(mongo --version)
  # Keep the version number
  mongo_ver=${mongo_ver#*: }
  mongo_ver=${mongo_ver%.*}
  # Concatenate major and minor version numbers together
  mongo_ver=${mongo_ver%.*}${mongo_ver#*.}
fi

if [ "$mongo_ver" -gt 25 ]
  then echo You have the newer MongoDB version available

# http://andyfelong.com/2016/01/mongodb-3-0-9-binaries-for-raspberry-pi-2-jessie/
elif [ $ARCH = arm ] && [ $PKG = deb ]
then
  $install mongodb
  wget https://www.dropbox.com/s/diex8k6cx5rc95d/core_mongodb.tar.gz
  tar -xvzf core_mongodb.tar.gz -C /usr/bin
  rm core_mongodb.tar.gz
  whiptail --yesno "MongoDB successfully installed. You need to reboot to use MongoDB. Reboot now?" 8 48
  case $? in
    0) reboot;;
    1) ;; # Continue
  esac
elif [ $ARCH = armv6 ] && [ $PKG = deb ]
then
  $install mongodb
  wget --no-check-certificate https://dl.bintray.com/4commerce-technologies-ag/meteor-universal/arm_dev_bundles/mongo_Linux_armv6l_v2.6.7.tar.gz
  tar -xvzf mongo_Linux_armv6l_v2.6.7.tar.gz -C /usr/bin
  rm mongo_Linux_armv6l_v2.6.7.tar.gz

# Debian (deb) based OS
elif [ $PKG = deb ]
  then
  apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv EA312927
  # Ubuntu repository
  if [ $DIST = ubuntu ]
    then echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
  # All other Debian based distributions
  else
    echo "deb http://repo.mongodb.org/apt/debian wheezy/mongodb-org/3.2 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
  fi
  apt-get update
  $install mongodb-org

# Red Hat (rpm) based OS
elif [ $PKG = rpm ]
  then echo '[mongodb-org-3.2]' > /etc/yum.repos.d/mongodb-org-3.2.repo
  echo 'name=MongoDB Repository' >> /etc/yum.repos.d/mongodb-org-3.2.repo
  if grep 'Amazon' /etc/issue 2>/dev/null
    then echo 'baseurl=https://repo.mongodb.org/yum/amazon/2013.03/mongodb-org/3.2/x86_64/' >> /etc/yum.repos.d/mongodb-org-3.2.repo
  else
    echo 'baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.2/x86_64/' >> /etc/yum.repos.d/mongodb-org-3.2.repo
  fi
  echo 'gpgcheck=0' >> /etc/yum.repos.d/mongodb-org-3.2.repo
  echo 'enabled=1' >> /etc/yum.repos.d/mongodb-org-3.2.repo

  $install mongodb-org

else
  # If mongodb installation return an error, manual installation required
  $install mongodb || {echo You probably need to manually install MongoDB; exit 1}
fi

## Install Dependencies
# SYSTEM CONFIGURATION

cd
# https://github.com/RocketChat/Rocket.Chat.RaspberryPi
if [ $ARCH = arm ] || [ $ARCH = armv6 ]
then
  $install python make g++ git
  # Get required node and npm
  git clone --depth 1 https://github.com/4commerce-technologies-AG/meteor

  # Fix curl CA error
  echo insecure > ~/.curlrc
  ~/meteor/meteor -v
  rm ~/.curlrc

  # Download the Rocket.Chat binary for Raspberry Pi
  curl https://cdn-download.rocket.chat/build/rocket.chat-pi-develop.tgz -o rocket.chat.tgz
  tar zxvf rocket.chat.tgz

  mv bundle Rocket.Chat
  # Install dependencies and start Rocket.Chat
  cd Rocket.Chat/programs/server
  ~/meteor/dev_bundle/bin/npm install

# https://github.com/RocketChat/Rocket.Chat/wiki/Deploy-Rocket.Chat-without-docker
elif [ $ARCH = amd64 ] || [ $ARCH = 86 ]
then
  $install graphicsmagick

  # Install NodeJS
  [ "$(node -v)" != "" ] && echo You have NodeJS already installed && break

  curl -sL https://$PKG.nodesource.com/setup_4.x | bash -
  $install nodejs

  # Install Meteor
  curl https://install.meteor.com | /bin/sh

  # Install a tool to let us change the node version.
  npm install -g n

  # Meteor needs at least this version of node to work.
  n 0.10.42

  ## Install Rocket.Chat
  # Download Stable version of Rocket.Chat

  curl -L https://rocket.chat/releases/latest/download -o rocket.chat.tgz

  tar zxvf rocket.chat.tgz

  mv bundle Rocket.Chat
  cd Rocket.Chat/programs/server
  npm install
else
    whiptail --msgbox "Your architecture ($ARCH) isn't supported" 8 48 exit 1
fi

whiptail --yesno --title "[OPTIONAL] Setup MongoDB Replica Set" "Rocket.Chat uses the MongoDB replica set OPTIONALLY to improve performance via Meteor Oplog tailing. Would you like to setup the replica set? " 12 48 \
--yes-button No --no-button Yes
if [ $? = 1 ]
then
  # Mongo 2.4 or earlier
  if [ $mongo_version -lt 25 ]
    then echo replSet=001-rs >> /etc/mongod.conf
  # Mongo 2.6+: using YAML syntax
  else
    echo 'replication:
        replSetName:  "001-rs"' >> /etc/mongod.conf
  fi
  service mongod restart
  mongo

  # Start the MongoDB shell and initiate the replica set
  mongo rs.initiate

  # RESULT EXPECTED
  # {
  #  "info2" : "no configuration explicitly specified -- making one",
  #  "me" : "localhost:27017",
  #  "info" : "Config now saved locally.  Should come online in about a minute.",
  #  "ok" : 1
  # }

  export MONGO_OPLOG_URL=mongodb://localhost:27017/local
fi

# Set environment variables
whiptail --title "Rocket.Chat port" --clear --inputbox "Enter your Rocket.Chat port number. default:[3000]" 8 32 2> /tmp/temp
read port < /tmp/temp
port=${port:-3000}

# Add supervisor process and run the server
if [ $ARCH = amd64 ] || [ $ARCH = 86 ]
  then node="node main.js"
elif [ $ARCH = arm ] || [ $ARCH = armv6 ]
  then node="$HOME/meteor/dev_bundle/bin/node main.js"
fi
# Install supervisor if not already present
hash supervisorctl 2>/dev/null || $install supervisor

# Create supervisor service
cat > /etc/supervisor/conf.d/Rocket.Chat.conf <<EOF
[program:Rocket.Chat]
command=sh -c "ROOT_URL=http://$IP:$port/ MONGO_URL=mongodb://localhost:27017/rocketchat PORT=$port $node"
directory=$HOME/Rocket.Chat
autostart=true
autorestart=unexpected
user=$USER
stderr_logfile=/var/log/Rocket.Chat.err.log
stdout_logfile=/var/log/Rocket.Chat.out.log
EOF
supervisorctl reread
supervisorctl update

whiptail --msgbox "Rocket.Chat successfully installed!

Open http://$IP:$port in your browser and register.

The first users to register will be promoted to administrator.

You can use this following command to manage the Rocket.Chat process
supervisorctl {start|stop|status} Rocket.Chat

For the logs, look in /var/log/Rocket.Chat*" 16 80
