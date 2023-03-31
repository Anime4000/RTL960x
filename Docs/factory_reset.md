# Factory Reset
## WARNING
This guide mainly for `RTL9601CI` and `RTL9601D` where `config` partition located at `/dev/mtd3`. Improper procedure can lead to brick, blank image, everything is at your own RISK!

# Backup
## Whole System
[Follow This Guide](https://github.com/Anime4000/RTL960x/discussions/28#discussion-4043058)

## Quick
1. `ELAN_MAC_ADDR`
2. License Key
    * ODI DFP-34X-2C2 `MAC_KEY`
    * VSOL V2801F `VS_AUTH_KEY`

# Reset
Login into `telnet` then do:
```
flash_eraseall /dev/mtd3
reboot
```
After reset, Stick will use default (hardcoded software) MAC Address, wrong `key` will not Authenticated to OLT!

## Semi Automated reset script

There is a script [reset-config-partition.sh] in this repo which was created to automate some operations.
If there is no mess with the VLAN configuration, it could be possible to reset the device to factory settings using SSH
or WebUI connection. Sometimes it could be harder when the stick is in the endless loop: the network appears up for a 
few seconds until the stick gets rebooted, but as usual it's enough to send the necessary commands into the stick to do 
the job.

[reset-config-partition.sh] had been tested with **ODI DFP-34X-2C2** with **220923** firmware. The process looks like 
this (Linux/MacOS):
1. It's obvious that you have the correct routing at your switch/router. Routing is not the subject of this article.
2. In one terminal I run `ping 192.168.100.100` just to see when the stick comes online. 
   Sometimes I can see 1 ping back, sometimes 4. In this example `192.168.100.100` is the custom IP of the stick. 
   The default IP as usual `192.168.1.1`.
3. At the second terminal invoke `./reset-config-partition.sh ssh 192.168.100.100 admin password`. Take a look into the 
   script [reset-config-partition.sh] and check for the parameters. In this example:
   - `./reset-config-partition.sh` - path to the script
   - `ssh` - which connection type to use. Possible values are `ssh` and `curl`. For `ssh` type you need to have 
     `sshpass` binary installed. In Ubuntu you can install with `apt install sshpass`. At MacOS use Homebrew and:
     `brew install sshpass`. Google for other distros :)
     
     It's possible to use `curl` method and no additional software as usual is required, but it was noticed that 
     reseting via WebUI not wipes the config partition, but just resets the IP address and the passwords.
   - `admin` - the admin username
   - `password` - the admin password.

   If you forgot the username - you can try to use the system users (yes, there is a backdoor in the stick :)). 
   Credentials are:
     - User `adsl` and password is `realtek`.
     - User `user` and password is `user` (could be changed later by `flash set USER_PASSWORD 123123`).
     - User `administrator` and password is `Stel$864` (could be changed later by `flash set E8BDUSER_PASSWORD 123123`).
4. Just wait until the script ereases the partition. Sometimes it could take up to 12-20 minutes to catch for the enough 
   interval when ssh/WebUI is available. When using SSH method - you'll see something like 
   `Erasing 4 Kibyte @ 3b000 -- 98 % complete.`. The script should finish ithself.
5. Here you can repeat the operation (I did), or reboot the stick. You can try just to re-plug it into the 
   switch/router/mediaconverter device. If it's not possible, you can try the script with little different parameters:
   `./reset-config-partition.sh ssh 192.168.100.100 admin password reboot`. At the third terminal run `ping 192.168.1.1`
   (i do not cover routing setup here) and ...just wait. After the succesfull reset process the device should appear at 
   `192.168.1.1`. Unfortunately the script does not catch an exit status correctly, so after you see the ping - interrupt
   the script with Ctrl+C.
6. Log into the device using the default credentials and IP address. After the resetting `MAC_KEY` is lost and the 
   MAC address is lost as well. You can `flash set ...` them later. 

---
[reset-config-partition.sh]: ../Tools/reset/reset-config-partition.sh
