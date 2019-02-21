# Centos 6 installation GUI
[yangspot.com](http://yangspot.com)
Optional: Run the following command to list down the available package groups for CentOS 7.
# yum group list
Output:
Loaded plugins: fastestmirror
There is no installed groups file.
Maybe run: yum groups mark convert (see man yum)
Loading mirror speeds from cached hostfile
Available Environment Groups:
 Minimal Install
 Compute Node
 Infrastructure Server
 File and Print Server
 Basic Web Server
 Virtualization Host
 Server with GUI
 GNOME Desktop
 KDE Plasma Workspaces
 Development and Creative Workstation
Available Groups:
 Compatibility Libraries
 Console Internet Tools
 Development Tools
 Graphical Administration Tools
 Legacy UNIX Compatibility
 Scientific Support
 Security Tools
 Smart Card Support
 System Administration Tools
 System Management
Done
# Step 1: Install Gnome GUI packages using the YUM command.
CentOS 7:
# yum groupinstall "GNOME Desktop" "Graphical Administration Tools"
RHEL 7:
# yum groupinstall "Server with GUI"

# Step 2: Enable GUI on system startup. In CentOS 7 / RHEL 7,  systemd uses “targets” instead of runlevel. 
The /etc/inittab file is no more used to change run levels. 
So, issue the following command to enable the GUI on system start.

# ln -sf /lib/systemd/system/runlevel5.target /etc/systemd/system/default.target
# Step 3: Reboot the machine to start the server in the graphical mode.

# reboot
[Back To Top](#)
