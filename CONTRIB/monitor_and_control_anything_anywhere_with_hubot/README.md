# Running hubot on your RockOnPi 

Hubot is a robot that you can easily code for RocketOnPi.

On your Pi server, hubot can easily:

* listen to messages on any Rocket.Chat channel - perhaps for commands
* send messages to any Rocket.Chat channel - perhaps to report status
* interface with almost ANYTHING you have connected to your Pi - anything that can be interface via node.js

Please see hubot for background information.


### STEPS

### INSTALL hubot

n. register a new user named bot on your Rocket.Chat, set its password, you can also set its avatar if you like
n. login as your pi user, use another console session from the running Rocket.Chat;  you have 4 cores on a Pi 2, most hubot scripts use very few CPU cycles
n. add the binary path `PATH=$PATH:$HOME/meteor/dev_bundle/bin`
n. install hubot generator via `sudo npm install -g yo generator-hubot`; this will take quite a while on a Pi 2
n. now generate a new hubot with `yo hubot` - and then answer the questions; this will generate a hubot in the hubot directory
n. `cd hubot` and take a look at all the scripts in the `scripts` directory; you can add any new hubot scripts here
n. setup your environment variables, according to hubot-rocketchat requirements, see [hubot-rocketchat]()   -- for example:
```
export ROCKETCHAT_ROOM=''
export LISTEN_ON_ALL_PUBLIC=true
export ROCKETCHAT_USER=bot
export ROCKETCHAT_PASSWORD=<your bot user password>
export ROCKETCHAT_AUTH=password
```
n.  now run your hubot, it will log the bot user into your Rocket.Chat and start it listening to commands:   `bin/hubot -a rocketchat`
n.  login to Rocket.Chat (not as bot), and issue the command `bot help` in GENERAL,  the bot should reply with a list of commands that it knows;  congrats, you now have HubotOnPi running!
