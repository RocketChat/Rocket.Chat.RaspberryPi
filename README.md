[![Rocket.Chat on Pi Logo](https://raw.githubusercontent.com/Sing-Li/bbug/master/images/raspberry-logo.png)](https://www.raspberrypi.org/)

* Raspberry Pi is the tiny $30 quad-core computer that revolutionalized affordable servers
* Rocket.Chat is the popular high performance, large capacity, open source web chat platform that rocked the server world 

You can now run a private chat server on your Pi for:
* family
* social or hobby group
* sports team
* school
* office

![Picture of mobile Rocket.Chat in action](https://cloud.githubusercontent.com/assets/11763113/11993320/ccdcf296-aa72-11e5-9950-e08f7a280516.png)

Enjoy Rocket.Chat features including:
* Video and audio chat
* Share photos and voice messages
* Share streaming music and video links
* iOS app for iPhones and iPads
* App for Android phones and tablets 
* Desktop app for Windows, MacOSX and Linux
* Operate in 22 different languages
* Multiple Rooms
* Direct Messages
* Private Groups
* Off the record encrypted messages
* Avatars
* Emojis
* Media Embeds
* Link Previews
* Many more ...

### Background

This project adapts the Rocket.Chat server to run on a Raspberry Pi 3

<img src="https://raw.githubusercontent.com/Sing-Li/bbug/master/images/rockpismal.png" width="480">

Learn about [Rocket.Chat](https://rocket.chat/).

### Installation 

You can get a Rocket.Chat server and a mongoDB instance working on your Raspiberry Pi 2 or Pi 3 in a couple of minutes with Ubuntu Core 16!

* Follow these instructions to download and install the [Ubuntu Core 16 SD card image for your Raspberry Pi 2 or Pi 3](https://developer.ubuntu.com/en/snappy/start/raspberry-pi-2)
* Perform `sudo snap install rocketchat-server`.  This will take a couple of mintues.   Wait about 2 minutes after everything has completed.  
* Then, access `http://<server ip>:3000` to access your Rocket.Chat server!   Create the first user, which will become the server's adminsitrator.  Have fun!

#### Put your chat server on the Internet for global access

With your Rocket.Chat server up and running, start another shell - typically (Ctrl-Alt-F2) or (Ctl-Alt-F3).

Login, download and start ngrok (see ngrok.com if you need more information):

curl  https://dl.ngrok.com/ngrok_2.0.19_linux_arm.zip -o ngrok.zip
unzip ngrok.zip
cd ngrok
./ngrok http 3000
Now follow the instruction and give the ngrok link to your friends and family anywhere in the world.

They can access your server via the ngrok link.

#### Enable https://  support for your domain name

If you have a registered domain name and a static IP address for your Pi, you can expose your server on the Internet with automatic SSL support.   See this for instructions on caddy (reverse proxy that is included in the installation snap)  configuration:  https://rocket.chat/docs/installation/manual-installation/ubuntu/snaps/autossl

HINT: if you want to use the voice and video chat features, make sure you give them the link starting with https://

Make sure you are using a **Pi 3 (or Pi 2)** with these instructions.   

Pi Zero,  Pi Model B, Pi Model B+,  or even Pi Model A can all run Rocket.Chat;  but have  different CPU, memory configurations and instruction sets  that may  require some additional work - see [FAQ](https://github.com/RocketChat/Rocket.Chat.RaspberryPi/wiki/Frequently-Asked-Questions) to work with these Pi s.

Our community members are running Rocket.Chat on EVERY MODEL of Pi ever manufactured - so come over to our [friendly community hangout](https://demo.rocket.chat/channel/raspberrypi) if you get stuck.

And YES, Rocket.Chat even runs on the $5 Pi Zero!  Making it _the first-ever $5 private social network that EVERYONE can afford_ !

![A $5 private social network that EVERYONE can afford ](https://raw.githubusercontent.com/Sing-Li/bbug/master/images/pizero.png)


#### Old way of manual installation:  On Raspbian only

Make sure you start with a CLEAN INSTALL of **Raspbian JESSIE  -- NOT Wheezy**

##### Get latest Raspian for your Pi

Find download here (this instruction assumes Raspbian Jessie):

https://www.raspberrypi.org/downloads/raspbian/


Use the shell (you do not need the GUI), get the latest fix and updates:

``` sh
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install git
```

#####  Get required node and npm

The version of `node` distributed with Raspian is too old.  `npm` is not included.

The easiest way to get both is to clone from the Meteor universal project.

``` sh
cd $HOME
git clone --depth 1 -b release-1.2.1-universal  https://github.com/4commerce-technologies-AG/meteor.git
```

then

`$HOME/meteor/meteor -v`


At this point, you may encounter a `curl` execption with ca problem.  This is confirmed to be a bug with the latest Debian/Raspbian, and will be fixed in time.  Meanwhile, please see [FAQ question #1](https://github.com/RocketChat/Rocket.Chat.RaspberryPi/wiki/Frequently-Asked-Questions)  for a bypass / temporary fix.

Retry the above command after the curl fix.

#####  Download the Rocket.Chat binary for Raspberry Pi

``` sh
cd $HOME
mkdir rocketchat
cd rocketchat
curl https://cdn-download.rocket.chat/build/rocket.chat-pi-develop.tgz -o rocket.chat.tgz
tar zxvf rocket.chat.tgz
```

This will download and untar the app in `$HOME/rocketchat`

Alternatively, you can find the latest release [here](https://github.com/RocketChat/Rocket.Chat.RaspberryPi/releases), and just download it.

##### Get a compatible MongoDB instance

Current available mongodb versions on Raspbian are too old for Rocket.Chat. Hopefully the
situation will change shortly.

Meanwhile, you can use a MongoDB service provider on the Internet.  MongoLab offers 
free sandbox databases that can be used with Rocket.Chat.  Create a free account and
database here:

https://mongolab.com/

Create a user and give it write access to the database.  Note the Mongo URL, you will
need it next.

##### Install dependencies and start Rocket.Chat

``` sh
cd $HOME/rocketchat/bundle/programs/server
$HOME/meteor/dev_bundle/bin/npm install
```

Next,

``` sh
cd $HOME/rocketchat/bundle
```

Type the following ALL on one single line, with spaces to separate the environment variables:
``` sh
PORT=3000  ROOT_URL=http://localhost:3000   MONGO_URL=mongodb://<user>:<password>@<host>:<port>/dataurlfrommongolabs    $HOME/meteor/dev_bundle/bin/node main.js
```
Wait until the server fully starts. About a minute.


##### Access your Rocket.Chat server and create the Administrative user

Point a browser on your PC to your Raspberry Pi:

http://rasp pi host IP:3000/


##### Put your chat server on the Internet for global access

With your Rocket.Chat server up and running, start another shell - typically (Ctrl-Alt-F2) or (Ctl-Alt-F3).

Login, download and start ngrok (see [ngrok.com](https://ngrok.com) if you need more information):

``` sh
curl  https://dl.ngrok.com/ngrok_2.0.19_linux_arm.zip -o ngrok.zip
unzip ngrok.zip
cd ngrok
./ngrok http 3000
```

Now follow the instruction and give the ngrok link to your friends and family anywhere in the world.  

They can access your server via the ngrok link.  

HINT:  if you want to use the voice and video chat features, make sure you give them the link starting with `https://`

##### Mobile messaging on phones and tablets

Ask your friends to download the Rocket.Chat mobile app on Android PlayStore or the Apple Appstore for their phone and tablets! 

Add your server's ngrok link to the app, and start mobile messaging one another!

### Large capacity server

Do you need to serve hundreds or even thousands of registered users?   If so, see how you can setup an inexpensive [high capacity Rocket.Chat server on Odroid XU4](https://github.com/RocketChat/Rocket.Chat.RaspberryPi/blob/master/CONTRIB/rocket_chat_on_odroid_xu4/README.md). 

### More fun with community contributions

RockOnPi community member @rdagger has contributed this excellent YouTube video on manual installation - just click on picture to watch:

[![From your phone, controll anything connected to your Pi](https://raw.githubusercontent.com/Sing-Li/bbug/master/images/pictrl.png)](https://youtu.be/BevcvRLsa9Y)


Try the following optional enchacements for your RocketOnPi, contributed by your friendly fellow community members:

[Auto re-start Rocket.Chat if Pi Reboots or Crashes](https://github.com/RocketChat/Rocket.Chat.RaspberryPi/tree/master/CONTRIB/restart_after_reboot_with_supervisor),  by @elpatron68 and @j8r

[![Hubot](https://raw.githubusercontent.com/Sing-Li/bbug/master/images/hubotport.png)](https://hubot.github.com/)

[Monitor or control anything connected to your Pi, from anywhere - hubot style!](https://github.com/RocketChat/Rocket.Chat.RaspberryPi/tree/master/CONTRIB/monitor_and_control_anything_anywhere_with_hubot),  by @sing-li

### Stuck?  Need help?

First, check our list of [Frequently Asked Questions](https://github.com/RocketChat/Rocket.Chat.RaspberryPi/wiki/Frequently-Asked-Questions) to see if your question is already included.

If not, create an issue here:     https://github.com/RocketChat/Rocket.Chat.RaspberryPi/issues/new

OR

Come join us at https://demo.rocket.chat/ to get help from friendly  RockOnPi community members and Rocket.Chat dev team.

### RockOnPi Community meetup 24 x 7

The RockOnPi community gathers at https://demo.rocket.chat/channel/raspberrypi  - and talk Pi !!

### Makers Ahoy!

Your imagination is your only limit.

Both Raspberry Pi and Rocket.Chat are open source, 100% programmable, 100% Makers-ready!

* get the Raspberry Pi Camera into a Rocket.Chat room
* hook up your home control project to Rocket.Chat
* manage your fleet of drones remotely on the web via RC on Pi

Tell us about your innovative project, or find other collaborators at:

https://demo.rocket.chat/channel/raspberrypi

### Support this project

Help us spread the word about this project!  

Tell all your Pi and Maker friends!  Show off Rocket.Chat at your next meetup!

Tweet about us, or show off Pi with Rocket.Chat on Facebook!

Order a Rocket.Chat sticker for your [Mac](https://www.stickermule.com/marketplace/10009-rocket-dot-chat-logo), [tablet](https://www.stickermule.com/marketplace/9987-rocket-dot-chat), or [Pi case](https://www.stickermule.com/marketplace/9989-rocket-dot-chat)!

### Where to get the Raspberry Pi server
* [Off the shelf at any Microsoft store](http://www.microsoftstore.com/store/msusa/en_US/pdp/Raspberry-Pi-2-Model-B-%2B-8GB-microSD-Bundle/productID.328659700)
* [Microcenter](http://www.microcenter.com/product/460968/Raspberry_Pi_3_Model_B)
* [Frys](http://frys.com/product/8402328?site=sr:SEARCH:MAIN_RSLT_PG)
* [Adafruit](https://www.adafruit.com/product/2358)
* [Sparkfun](https://www.sparkfun.com/products/13297)
* [Amazon](http://www.amazon.com/Raspberry-Pi-Model-Project-Board/dp/B00T2U7R7I)
* [Element 14](http://www.element14.com/community/community/raspberry-pi/raspberrypi2)
* [Mercado Livre Brazil](http://lista.mercadolivre.com.br/raspberry-pi-2-1gb#D)
* [RS Japan](http://jp.rs-online.com/web/p/processor-microcontroller-development-kits/832-6274/)

### Where to get Rocket.Chat

Apps for iPhone, iPad, Android, Windows, MacOSX:

https://Rocket.Chat/

Server source code (open source MIT Licensed):

https://github.com/rocketchat/Rocket.Chat

