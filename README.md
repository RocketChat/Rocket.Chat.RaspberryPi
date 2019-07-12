[![Rocket.Chat on Pi Logo](https://raw.githubusercontent.com/Sing-Li/bbug/master/images/raspberry-logo.png)](https://www.raspberrypi.org/)

* Raspberry Pi is the tiny $35 quad-core computer that revolutionalized affordable servers
* Rocket.Chat is the popular high performance, large capacity, open source team communications platform that rocked the server world 

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

This project adapts the Rocket.Chat server to run on a Raspberry Pi 4

<img src="https://raw.githubusercontent.com/Sing-Li/bbug/master/images/rockpismal.jpg" width="480">

Learn about [Rocket.Chat](https://rocket.chat/).

### Prerequisites

* Raspberry Pi 4 or newer (2 GB or 4 GB version recommended)
* the fastest and largest capacity microSD you can get, we recommend 128GB Class 10 or higher
* Proper stable power supply for USB-C (5V 3A or more)
* Internet connection

### Up and running your own private Rocket.Chat server in minutes

You can get a Rocket.Chat server and a mongoDB instance working on your Raspiberry Pi 4 Model B (either 2GB or 4GB) in a few minutes.     Here's how:

1. Prepare your SD-Card: download [_Raspbian Buster Lite_ image](https://www.raspberrypi.org/downloads/raspbian/) dated July 2019 or later. You can find help installation manuals and setup video guides on that sites as well.

1. Log in to your Pi with the standard username "pi" and password "raspberry". If you want to log in remotely via SSH you have will have to [enable SSH](https://www.raspberrypi.org/documentation/remote-access/ssh/README.md).

1. Now change the default password and set your locales, timezone and keyboard layout with `sudo raspi-config`.

1. `sudo apt update && sudo apt install snapd` to install the snap daemon (snap is an amazing technology created by Canonical/Ubuntu that makes installation of complex application and/or servers really simple)

1. `sudo reboot` now reboot your Pi (according to https://docs.snapcraft.io/installing-snap-on-raspbian/6754)

1.  Perform `sudo snap install rocketchat-server`.  This will take at least a couple of mintues. PLEASE BE PATIENT!  I know how difficult it may be waiting for your own private social network to be birthed.  BUT please wait a few minutes until everything has been completed.  

#### That's it, your private chat server should now be LIVE!

Point a PC/Laptop browser on the same network as your Pi to `http://<server ip>:3000` and\ access your Rocket.Chat server!   Create the first user, which will become the server's adminsitrator.  **Have fun!**

Read about the [thousands of configuration / customization options available](https://rocket.chat/docs/administrator-guides/#administrator-guides) to you.

#### Put your chat server on the Internet for global access

With your Rocket.Chat server up and running, start another shell - typically (Ctrl-Alt-F2) or (Ctl-Alt-F3).

Login, download and start ngrok (see ngrok.com if you need more information):

```shell
$ curl https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip -o ngrok.zip
$ unzip ngrok.zip
$ cd ngrok
$ ./ngrok http 3000
```

Now follow the instruction and give the ngrok link to your friends and family anywhere in the world.

They can access your server via the ngrok link.

#### Enable https://  support for your domain name

If you have a registered domain name and a static IP address and want to easily put your Pi on a domain, you can use either:

1.  use the built-in caddy server -- see all the related instructions on our [snap auto SSL with Lets Encrypt and Caddy documentation](https://rocket.chat/docs/installation/manual-installation/ubuntu/snaps/autossl/#enabling-caddy) 
1.  install Nginx [NGINX reverse proxy for Rocket.Chat]()

HINTS: 
* Don't forget to configure your router to forward ports 80 and 443 to the pi
* If you want to use the voice and video chat features, make sure you give them the link starting with https://

##### Mobile messaging on phones and tablets

Ask your friends to download the Rocket.Chat mobile app on Android PlayStore or the Apple Appstore for their phone and tablets! 

Add your server's ngrok link to the app, and start mobile messaging one another!
</details>

### Invite tons of users

On your Raspberry Pi 4 Model B with 2GB of RAM, you should comfortably host 50 users with moderate file share activity.  If you are deploying a 4GB model, you can easily extend that to 100s of users  (recommend  addition of a USB3 based 1TB SSD for object storage when used for file sharing communities). 

There are many other pocket-sized ARM servers that Rocket.Chat can run on.  See for example, on how to run [high capacity Rocket.Chat server on Odroid XU4](https://github.com/RocketChat/Rocket.Chat.RaspberryPi/blob/master/CONTRIB/rocket_chat_on_odroid_xu4/README.md). 

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

Come join us at https://open.rocket.chat/ to get help from friendly  RockOnPi community members and Rocket.Chat dev team.

### RockOnPi Community meetup 24 x 7

The RockOnPi community gathers at https://open.rocket.chat/channel/raspberrypi  - and talk Pi !!

### Makers Ahoy!

Your imagination is your only limit.

Both Raspberry Pi and Rocket.Chat are open source, 100% programmable, 100% Makers-ready!

* get the Raspberry Pi Camera into a Rocket.Chat room
* hook up your home control project to Rocket.Chat
* manage your fleet of drones remotely on the web via RC on Pi

Tell us about your innovative project, or find other collaborators at:

https://open.rocket.chat/channel/raspberrypi

### Support this project

Help us spread the word about this project!  

Tell all your Pi and Maker friends!  Show off Rocket.Chat at your next meetup!

Tweet about us, or show off Pi with Rocket.Chat on Facebook!

Order a Rocket.Chat sticker for your [Mac](https://www.stickermule.com/marketplace/10009-rocket-dot-chat-logo), [tablet](https://www.stickermule.com/marketplace/9987-rocket-dot-chat), or [Pi case](https://www.stickermule.com/marketplace/9989-rocket-dot-chat)!

### Where to get the Raspberry Pi server
* [Raspberry Pi 4 Model B with 2GB RAM at MicroCenter](https://www.microcenter.com/product/608186/4-model-b---2gb-ddr4)
* [Raspberry Pi 4 Model B with 4GB RAM at MicroCenter](https://www.microcenter.com/product/608187/4-model-b---4gb-ddr4)
* [Raspberry Pi 4 Model B with 2GB RAM at Newark](https://canada.newark.com/raspberry-pi/rpi4-modbp-2gb/raspberry-pi-4-model-b-2gb/dp/02AH3162)
* [Raspberry Pi 4 Model B with 4GB RAM at Newark](https://canada.newark.com/raspberry-pi/rpi4-modbp-4gb/raspberry-pi-4-model-b-4gb/dp/02AH3164)


### Where to get Rocket.Chat

Apps for iPhone, iPad, Android, Windows, MacOSX:

https://Rocket.Chat/

Server source code (open source MIT Licensed):

https://github.com/rocketchat/Rocket.Chat

