FROM asdlfkj31h/debian-wine:0.3
MAINTAINER Gerolf Ziegenhain <gerolf.ziegenhain@gmail.com>

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ADD install /install
#RUN mkdir -p /install
#RUN wget http://dxatlas.com/CwSkimmer/Files/CwSkimmer.zip -O /install/CwSkimmer.zip
RUN cat /root/novnc/vnc_lite.html | sed 's/<title>noVNC/<title>CW Skimmer/g' > /root/novnc/tmp.html && cat /root/novnc/tmp.html > /root/novnc/vnc_lite.html && rm /root/novnc/tmp.html
# Get Aggregator from http://www.reversebeacon.net/pages/Aggregator+34



RUN apt-get update
RUN apt-get -y install socat
RUN apt-get -y install pulseaudio pavucontrol
#RUN apt-get -qqy autoclean && rm -rf /tmp/* /var/tmp/*

#RUN apt-get -y install python-pip
#RUN pip install -U pywinauto

ADD startup.sh /bin

EXPOSE 8080

ENTRYPOINT ["startup.sh"]
CMD ["/usr/bin/supervisord"]

