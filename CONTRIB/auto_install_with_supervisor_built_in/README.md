# Single command install Rocket.Chat with supervisor

Use this single line command to install Rocket.Chat. A reboot will be needed for ARM boards, just re-execute this command after the reboot. This script is also intended to works on x86(-64) computers on Debian/RedHat based OS.

```sh
wget -qO- https://raw.githubusercontent.com/RocketChat/Rocket.Chat.RaspberryPi/master/CONTRIB/auto_install_with_supervisor_built_in/Rocket.Chat.sh | sh
```
