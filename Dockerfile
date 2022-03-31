FROM debian:buster AS wine
MAINTAINER Gerolf Ziegenhain <gerolf.ziegenhain@gmail.com>

# Configuration variables
ENV IP_HERMES "192.168.111.222"
ENV CALLSIGN "CW0SKIM"


# Install Wine, XFCE, network audio stuff
ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
RUN dpkg --add-architecture i386
RUN apt-get update && apt-get -y install xvfb x11vnc xdotool wget tar supervisor net-tools gnupg2 
RUN wget -O - https://dl.winehq.org/wine-builds/winehq.key |apt-key add -
RUN echo deb https://dl.winehq.org/wine-builds/debian/ buster main >>  /etc/apt/sources.list
# Contrib enable
RUN sed -r -i 's/^deb(.*)$/deb\1 contrib/g' /etc/apt/sources.list
# cf. http://ubuntuhandbook.org/index.php/2020/01/install-wine-5-0-stable-ubuntu-18-04-19-10/
RUN apt-get update && apt-get -y install libgnutls30:i386 libldap-2.4-2:i386 libgpg-error0:i386 libxml2:i386 libasound2-plugins:i386 libsdl2-2.0-0:i386 libfreetype6:i386 libdbus-1-3:i386 libsqlite3-0:i386 wine winetricks xfce4 socat pulseaudio pavucontrol
RUN apt-get -qqy autoclean && rm -rf /tmp/* /var/tmp/*
# cf. https://wiki.winehq.org/Debian
ENV WINEPREFIX /root/prefix32
ENV WINEARCH win32
ENV DISPLAY :0

# Deps for RBNAggregator
RUN winetricks -q dotnet46


FROM wine AS novnc
# Install noVNC stuff
WORKDIR /root/
RUN wget -O - https://github.com/novnc/noVNC/archive/v1.1.0.tar.gz | tar -xzv -C /root/ && mv /root/noVNC-1.1.0 /root/novnc && ln -s /root/novnc/vnc_lite.html /root/novnc/index.html
RUN wget -O - https://github.com/novnc/websockify/archive/v0.9.0.tar.gz | tar -xzv -C /root/ && mv /root/websockify-0.9.0 /root/novnc/utils/websockify
RUN cat /root/novnc/vnc_lite.html | sed 's/<title>noVNC/<title>CW Skimmer/g' > /root/novnc/tmp.html && cat /root/novnc/tmp.html > /root/novnc/vnc_lite.html && rm /root/novnc/tmp.html


FROM novnc AS installation
# Copy installation files
ADD install /install
# Copy Raw binaries (extracted from installations)
RUN mkdir /app
ADD lib /app


FROM installation as config
# XFCE config
ADD ./config/xfce4 /root/.config/xfce4
# Add startup stuff
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD startup.sh /bin

# Configuration stuff
ENV PATH_INI_SKIMSRV "/root/prefix32/drive_c/users/root/Application Data/Afreet/Products/SkimSrv"
RUN mkdir -p ${PATH_INI_SKIMSRV}
COPY ./config/rbn/Aggregator.ini /app/RBN
COPY ./config/skimsrv/SkimSrv.ini ${PATH_INI_SKIMSRV}
COPY ./lib/HermesIntf-21.7.18/HermesIntf.dll /app/SkimSrv/HermesIntf_${IP_HERMES}.dll
COPY ./lib/HermesIntf-21.7.18/HermesIntf.dll /app/Afreet/CwSkimmer/HermesIntf_${IP_HERMES}.dll



EXPOSE 8080
ENTRYPOINT ["startup.sh"]
CMD ["/usr/bin/supervisord"]

