#  Rocket.Chat for 1,000s on an Odroid XU4

[![Odroid XU4 has Octacore with 2 GB RAM](https://raw.githubusercontent.com/Sing-Li/bbug/master/images/odroid3.jpg)](http://www.hardkernel.com/main/products/prdt_info.php?g_code=G143452239825)


## Powerful $75 Octacore 2GB RAM server 

* Samsung Exynos5422 Octa core CPUs
* 2Gbyte LPDDR3 RAM PoP stacked
* eMMC5.0 HS400 Flash Storage
* 2 x USB 3.0 Host
* Gigabit Ethernet port

###  Custom kernel configuration

Manually upgrade the kernel to 4.2 to support AppArmor is required before snap install will work. 

Hardkernel is scheduled to update kernel to 4.2 in February of 2017, and this should no longer be necessary at that time.

See [custom kernel configuration](https://github.com/RocketChat/Rocket.Chat.RaspberryPi/blob/master/CONTRIB/rocket_chat_on_odroid_xu4/odroidxu4-kernel4.2-config)


###  Tiny Rocket.Chat server for thousands of users

Thanks to community genius [@avnerus](http://avner.js.org/) !

His  sever setup - house in an Odroid CloudShell ($39), with its own LCD display :

![CloudShell comes with its own LCD - can replace the need for a monitor](https://raw.githubusercontent.com/Sing-Li/bbug/master/images/odroid2.jpg)

Teamed with a Samsung SSD, connected via Super Fast USB 3, and the server is ready for thousands of Rocket.Chat users:

![SSD connected via USB 3 - ready for thousands of registered users](https://raw.githubusercontent.com/Sing-Li/bbug/master/images/odroid1.jpg)


