# Embeded WebGUI
porting from ancient HTML to modern HTML5!

* Bootstrap 5
* No jQuery! Pure JS
* SVG

# `boa.conf`
You need edit `/home/httpd/boa.conf` and add these after `AddType application/x-httpd-cgi asp` line:
```
AddType application/json map
AddType text/css css
AddType text/javascript js
```

# Example:
![GUI](../Docs/Images/webgui/1-login.png)
![GUI](../Docs/Images/webgui/2-status.png)
![GUI](../Docs/Images/webgui/3-status-pon.png)
![GUI](../Docs/Images/webgui/4-lan.png)
![GUI](../Docs/Images/webgui/5-vlan.png)
![GUI](../Docs/Images/webgui/6-omci-info.png)
![GUI](../Docs/Images/webgui/7-gpon.png)
![GUI](../Docs/Images/webgui/8-epon.png)
![GUI](../Docs/Images/webgui/9-fwup.png)
![GUI](../Docs/Images/webgui/10-backup-res.png)
![GUI](../Docs/Images/webgui/11-commit-reboot.png)

> There some not working javascript, display current setting might not work
