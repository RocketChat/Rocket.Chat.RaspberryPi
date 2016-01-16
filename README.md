[![Rocket.Chat on Pi Logo](https://raw.githubusercontent.com/Sing-Li/bbug/master/images/raspberry-logo.png)](https://www.raspberrypi.org/)

* Raspberry Pi 2 is the tiny $30 quad-core computer that revolutionalized affordable servers
* Rocket.Chat is the popular high performance, large capacity, open source web chat platform that rocked the server world 

You can now run a private chat server on your Pi for:
* family
* social or hobby group
* sports team
* school
* office

Enjoy Rocket.Chat features includiing:
* Video and audio chat
* iOS app for iPhones and iPads
* App for Android phones and tablets 
* Desktop app for Windows, MacOSX, and Linux
* Multiple Rooms
* Direct Messages
* Private Groups
* Avatars
* Emojis
* Media Embeds
* Link Previews
* Many more ...

### Background

This project adapts the Rocket.Chat server to run on a Raspberry Pi 2 

<img src="https://raw.githubusercontent.com/Sing-Li/bbug/master/images/rockpismal.png" width="480">

Learn about [Rocket.Chat](https://rocket.chat/).

This project is currently work in progress and is undergoing rapid changes.

### Running Rocket.Chat on Pi Server Quick Start

The shortest path to get Rocket.Chat running on your Pi:

#### Get latest Raspian for your Pi

Find download here (this instruction assumes Raspbian Jessie):

https://www.raspberrypi.org/downloads/raspbian/

Use the shell (you do not need the GUI), get the latest fix and updates:

```
sudo apt-get update
sudo apt-get upgrade
```

####  Get required node and npm

The version of `node` distributed with Raspian is too old.  `npm` is not included.

The easiest way to get both is to clone from the Meteor universal project.

```
cd $HOME
git clone --depth 1 https://github.com/4commerce-technologies-AG/meteor.git
```

then

`$HOME/meteor/meteor -v`

####  Download the Rocket.Chat binary for Raspberry Pi

````
cd $HOME
mkdir rocketchat
cd rocketchat
curl https://s3.amazonaws.com/rocketchat/build/rocket.chat-pi-develop.tgz -o rocket.chat.tgz
tar zxvf rocket.chat.tgz
````

This will download and untar the app in `$HOME/rocketchat`

#### Get a compatible MongoDB instance

Current available mongodb versions on Raspbian are too old for Rocket.Chat. Hopefully the
situation will change shortly.

Meanwhile, you can use a MongoDB service provider on the Internet.  MongoLab offers 
free sandbox databases that can be used with Rocket.Chat.  Create a free account and
database here:

https://mongolab.com/

Create a user and give it write access to the database.  Note the Mongo URL, you will
need it next.

#### Install dependencies and start Rocket.Chat

```
cd $HOME/rocketchat/bundle/program/server
$HOME/meteor/dev_bundle/bin/npm install
cd $HOME/rocketchat/bundle
PORT=3000  ROOT_URL=http://localhost:3000   MONGO_URL=mongo://user@password:dataurlfrommongolabs    $HOME/rocketchat/dev_bundle/bin/node main.js
```

Wait until the server fully starts. About a minute.

#### Access your Rocket.Chat server and create the Administrative user

Point a browser on your PC to your Raspberry Pi:

http://rasp pi host IP:3000/

#### Put your chat server on the Internet for global access

With your Rocket.Chat server up and running.

Download ngrok:

```
curl  https://dl.ngrok.com/ngrok_2.0.19_linux_arm.zip -o ngrok.zip
unzip ngrok.zip
cd ngrok
./ngrok http 3000
```

Now follow the instruction and give the ngrok URL to your friends and family anywhere in the world.  

They can access your server via the URL.  


#### Stuck?  Need help?

Create an issue here:     https://github.com/RocketChat/Rocket.Chat.RaspberryPi/issues/new

OR

Come join us at https://demo.rocket.chat/ to get help from our friendly community and the dev team.

#### Community meetup 24 x 7

Let's all gather at https://demo.rocket.chat/channel/raspberrypi  - and talk Pi !!

### Where to get the Raspberry Pi 2 server
* [Microcenter](http://www.microcenter.com/product/447313/2_Model_B_Development_Board)
* [Frys](http://frys.com/product/8402328?site=sr:SEARCH:MAIN_RSLT_PG)
* [Amazon](http://www.amazon.com/Raspberry-Pi-Model-Project-Board/dp/B00T2U7R7I)
* [Element 14](http://www.element14.com/community/community/raspberry-pi/raspberrypi2)
* [Mercado Livre](http://lista.mercadolivre.com.br/raspberry-pi-2-1gb#D)

### Where to get Rocket.Chat

Apps for iPhone, iPad, Android, Windows, MacOSX:

https://Rocket.Chat/

Server source code (open source MIT Licensed):

https://github.com/rocketchat/Rocket.Chat

### Want ready-to-run servers?

Support the project.  Donate $100 or more to the project and we will ship you a ready-to-run server, anywhere in North American, Europe, Japan, or Brazil.
