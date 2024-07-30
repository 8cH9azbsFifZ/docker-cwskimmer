#!/bin/bash

dpkg --add-architecture i386
apt-get update && apt-get -y install xvfb x11vnc xdotool wget tar supervisor net-tools gnupg2 procps
sed -r -i 's/^deb(.*)$/deb\1 contrib/g' /etc/apt/sources.list
apt-get update && apt-get -y install libgnutls30:i386 libldap-2.4-2:i386 libgpg-error0:i386 libxml2:i386 libasound2-plugins:i386 libsdl2-2.0-0:i386 libfreetype6:i386 libdbus-1-3:i386 libsqlite3-0:i386 wine winetricks xfce4 socat pulseaudio pavucontrol

export WINEPREFIX /root/prefix32
export WINEARCH win32

winetricks -q dotnet46

apt-get -y install innoextract

