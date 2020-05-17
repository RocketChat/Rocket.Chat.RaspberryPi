# Running Rocket.Chat on Ubuntu 20.04lts with Docker

Raspberry Pi 4 (2GB or 4GB configuration) can run 64bit Ubutnu 20.04lts readily.   

And ubuntu has [made it straigthforward to download image and install the operating system](https://ubuntu.com/download/raspberry-pi).

Unfortunately, there is [a bug with existing arm64 snap](https://github.com/RocketChat/Rocket.Chat.Embedded.arm64/issues/1) that affects mongodb, and snaps cannot be used to install Rocket.Chat on 20.04lts at the moment.
