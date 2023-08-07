#!/usr/bin/env bash

# this will overwrite all the settings it touches

# the name of the user to run these commands as
TARGET_USER=kash

# to start the desktop session remotely
echo -e "[daemon]\nAutomaticLogin=${TARGET_USER}\nAutomaticLoginEnable=true\n" | sudo tee /run/gdm/custom.conf
sudo systemctl restart gdm

# print the session type
busctl get-property org.freedesktop.Accounts /org/freedesktop/Accounts/User$(id -u) org.freedesktop.Accounts.User Session

# the password for that target user (needed to unlock their keyring)
TUP="iamkroot"

# password to use for VNC server
VNC_PASS="iamkroot"

# TODO: unlock the keyring (probably by first killing it and then re-launching it like PAM would)
#killall gnome-keyring-daemon
#echo -n ${TUP} | gnome-keyring-daemon --daemonize --login

# write vnc password to the keychain
sudo -i -u ${TARGET_USER} VNC_PASS="${VNC_PASS}" DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u ${TARGET_USER})/bus" bash -c 'echo -n ${VNC_PASS} | secret-tool store --label "GRD VNC pass" xdg:schema org.gnome.RemoteDesktop.VncPassword'
# or if you want you can print the existing password with
# secret-tool lookup xdg:schema org.gnome.RemoteDesktop.VncPassword

# allow screen control
sudo -i -u ${TARGET_USER} DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u ${TARGET_USER})/bus" bash -c 'gsettings set org.gnome.desktop.remote-desktop.vnc view-only false'

# use password authentication
sudo -i -u ${TARGET_USER} DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u ${TARGET_USER})/bus" bash -c 'gsettings set org.gnome.desktop.remote-desktop.vnc auth-method password'

# let's also setup RDP creds just for fun
RDP_USER="kash"
RDP_PASS="iamkroot"
RDP_CREDS="{\"password\": \"${RDP_PASS}\", \"username\": \"${RDP_USER}\"}"

TLS_STORE=/var/tmp/rdptls
mkdir -p ${TLS_STORE}
# generate the TLS things for the RDP server
winpr-makecert -rdp -path ${TLS_STORE} > /dev/null

# write RDP credentials to the keychain
sudo -i -u ${TARGET_USER} RDP_CREDS="${RDP_CREDS}" DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u ${TARGET_USER})/bus" bash -c 'echo -n ${RDP_CREDS} | secret-tool store --label "GRD RDP creds" xdg:schema org.gnome.RemoteDesktop.RdpCredentials'

# set RDP tls certificate path
sudo -i -u ${TARGET_USER} TLS_CRT="${TLS_STORE}/$(hostname --fqdn).crt" DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u ${TARGET_USER})/bus" bash -c 'gsettings set org.gnome.desktop.remote-desktop.rdp tls-cert "${TLS_CRT}"'

# set RDP tls private key path
sudo -i -u ${TARGET_USER} TLS_KEY="${TLS_STORE}/$(hostname --fqdn).key" DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u ${TARGET_USER})/bus" bash -c 'gsettings set org.gnome.desktop.remote-desktop.rdp tls-key "${TLS_KEY}"'

# allow RDP remote control
sudo -i -u ${TARGET_USER} DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u ${TARGET_USER})/bus" bash -c 'gsettings set org.gnome.desktop.remote-desktop.rdp view-only false'

# now launch the server (needs to be run as the ${TARGET_USER}, haven't figured out how to fool pipewire yet)
/usr/lib/gnome-remote-desktop-daemon
