## Auto re-start Rocket.Chat if Pi Reboots or Crashes

NOTE: this will not work if you are using ngrok, because the ngrok URL will change everytime you restart the service 

Installing Rocket.Chat with supervisor makes sure your chat server starts at system boot and restarts if it crashes. Refer to [this tutorial](https://www.digitalocean.com/community/tutorials/how-to-install-and-manage-supervisor-on-ubuntu-and-debian-vps) for more information about Supervisor.  
* Install supervisor
`sudo apt-get install supervisor`

* Create a new configuration file for supervisor
``` sh
cat > /etc/supervisor/conf.d/Rocket.Chat.conf <<EOF
[program:RocketChat]
command=/home/pi/rocketchat/bundle/start_rcpi.sh
directory=/home/pi/rocketchat/bundle
autostart=true
autorestart=true
stderr_logfile=/var/log/Rocket.Chat.err.log
stdout_logfile=/var/log/Rocket.Chat.out.log
EOF
```
* Create `start_rcpi.sh`
``` sh
cat > $HOME/rocketchat/bundle/start_rcpi.sh <<EOF
#!/bin/sh
PORT=3000
ROOT_URL=http://localhost:3000
MONGO_URL=mongodb://<user>:<password>@<host>:<port>/dataurlfrommongolabs
/home/pi/meteor/dev_bundle/bin/node main.js
EOF
```
* Change MONGO_URL to match your settings (see above)

* Make `start_rcpi.sh` executable: `sudo chmod +x start_rcpi.sh`  

* Start supervisor:  
  ```
  sudo supervisorctl reread  
  sudo supervisorctl restart  
  ```
* Make sure everything is up and running
  ```
  pi@raspberrypi:~/rocketchat/bundle $ sudo supervisorctl
  RocketChat                       RUNNING    pid 26619, uptime 0:07:09
  ```
