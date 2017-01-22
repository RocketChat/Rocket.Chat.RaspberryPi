#  Rocket.Chat for 1,000s on an Odroid XU4

[![Odroid XU4 has Octacore with 2 GB RAM](https://raw.githubusercontent.com/Sing-Li/bbug/master/images/odroid3.jpg)](http://www.hardkernel.com/main/products/prdt_info.php?g_code=G143452239825)


## Powerful $75 Octacore 2GB RAM server 

* Samsung Exynos5422 Octa core CPUs
* 2Gbyte LPDDR3 RAM PoP stacked
* eMMC5.0 HS400 Flash Storage
* 2 x USB 3.0 Host
* Gigabit Ethernet port

###  Custom kernel configuration

Manually upgrading the kernel to 4.2 to support AppArmor is required before snap install will work. 

The instructions for upgrading the kernel are found on [Odroid's wiki](http://odroid.com/dokuwiki/doku.php?id=en:xu4_building_kernel).

This [custom kernel configuration](https://github.com/RocketChat/Rocket.Chat.RaspberryPi/blob/master/CONTRIB/rocket_chat_on_odroid_xu4/odroidxu4-kernel4.2-config) adds support for various Cloudshell necessities.

Make sure that in your *boot.ini* you reference the new dtb file instead of the old one:
```
fatload mmc 0:1 0x44000000 exynos5422-odroidxu4.dtb
```
You will also need to enable *AppArmor* in the boot line on *boot.ini*, example:
```
setenv bootrootfs "console=tty1 console=ttySAC2,115200n8 apparmor=1 security=apparmor root=UUID=1b7c64c5-e2c1-4e51-a010-ed4a62ce75dd rootwait ro fsck.repair=yes net.ifnames=0"
```
If your Cloudshell LCD doesn't turn on, change module definition on `/etc/modprobe.d/odroid-cloudshell.conf` to:
```
options fbtft_device name=hktft9340 busnum=1 rotate=270 gpios=reset:21,dc:22,led:18
```

Hardkernel is scheduled to officially update the kernel to 4.9 in February of 2017 so these changes should no longer be necessary by then.


###  Tiny Rocket.Chat server for thousands of users

Thanks to community genius [@avnerus](http://avner.js.org/) !

His  sever setup - house in an Odroid CloudShell ($39), with its own LCD display :

![CloudShell comes with its own LCD - can replace the need for a monitor](https://raw.githubusercontent.com/Sing-Li/bbug/master/images/odroid2.jpg)

Teamed with a Samsung SSD, connected via Super Fast USB 3, and the server is ready for thousands of Rocket.Chat users:

![SSD connected via USB 3 - ready for thousands of registered users](https://raw.githubusercontent.com/Sing-Li/bbug/master/images/odroid1.jpg)


