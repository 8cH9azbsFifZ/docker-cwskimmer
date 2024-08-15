FROM debian:bookworm AS wine

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
RUN apt-get update && apt-get -y install cabextract xvfb novnc x11vnc xdotool wget tar dbus-x11 supervisor net-tools gnupg2 procps wine xfce4 innoextract unzip
# Contrib enable
#RUN sed -r -i 's/^deb(.*)$/deb\1 contrib/g' /etc/apt/sources.list
#RUN apt-get -qqy autoclean && rm -rf /tmp/* /var/tmp/*
ENV DISPLAY :0

# Winetricks update
WORKDIR /root/
RUN wget  https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
RUN chmod +x winetricks 
RUN mv -v winetricks /usr/local/bin

FROM wine AS installation

ENV V_HERMES 21.7.18
ENV V_SKIMMER 2.1
ENV V_SKIMMERSRV 1.6
ENV V_RBNAGGREGATOR 6.3
#ENV DIR_SKIMMERSRV /skimmersrv_${V_SKIMMERSRV}/app

# Copy installation files and extract them
ADD install /install
WORKDIR /skimmer_1.9
RUN  unzip /install/Skimmer_1.9/CwSkimmer.zip && innoextract Setup.exe
WORKDIR /skimmer_${V_SKIMMER}
RUN unzip /install/Skimmer_${V_SKIMMER}/CwSkimmer.zip && innoextract Setup.exe
WORKDIR /skimmersrv_${V_SKIMMERSRV}
RUN unzip /install/SkimmerSrv_${V_SKIMMERSRV}/SkimSrv.zip && innoextract Setup.exe
WORKDIR /rbnaggregator_${V_RBNAGGREGATOR}
RUN unzip "/install/RBNAggregator/Aggregator v${V_RBNAGGREGATOR}.zip"
WORKDIR /HermesDLL_${V_HERMES}
RUN unzip /install/HermesDLL/HermesIntf-${V_HERMES}.zip
WORKDIR /HermesDLL_KV4TT
RUN cp /install/HermesDLL/HermesIntf.dll .
WORKDIR /CWSL
RUN cp /install/CWSL/CWSL/* .
WORKDIR /CWSL_DIGI
RUN cp -r /install/CWSL_DIGI/*/* .

# Install more stuff for CWSL
WORKDIR /root/.wine/drive_c/windows/system32
RUN unzip -n /install/IPP70/IPP70.zip 

# Install CWSL DIGI
WORKDIR /root/.wine/drive_c/CWSL_DIGI/
RUN cp -r /install/CWSL_DIGI/*/* .




# Add late installer
ADD ./install.sh /install

WORKDIR /root/


FROM installation as config
# FIXME: config vars here -e RIGSERVER=10.101.1.53 -e RIGSERVER_CAT_PORT=1234 -e RIGSERVER_PTT_PORT=4321 

# XFCE config
ADD ./config/xfce4 /root/.config/xfce4
# Add startup stuff
ADD ./config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD ./config/startup.sh /bin
ADD ./config/startup_sound.sh /bin

# Configuration stuff
ENV PATH_INI_SKIMSRV "/root/.wine/drive_c/users/root/Application Data/Afreet/Products/SkimSrv/SkimSrv.ini"
ENV PATH_INI_AGGREGATOR "/rbnaggregator_${V_RBNAGGREGATOR}/Aggregator.ini"
RUN mkdir -p $(dirname ${PATH_INI_SKIMSRV})
COPY ./config/rbn/Aggregator.ini ${PATH_INI_AGGREGATOR}
COPY ./config/skimsrv/SkimSrv.ini ${PATH_INI_SKIMSRV}
RUN cp /HermesDLL_${V_HERMES}/HermesIntf.dll /skimmersrv_${V_SKIMMERSRV}/app/
RUN rm /skimmersrv_${V_SKIMMERSRV}/app/Qs1rIntf.dll
COPY ./install/patt3ch/patt3ch.lst /skimmersrv_${V_SKIMMERSRV}/userappdata/Afreet/Reference/Patt3Ch.lst

ENV LOGFILE_HERMES /root/HermesIntf_log_file.txt
ENV LOGIFLE_AGGREGATOR /root/AggregatorLog.txt

## Configuration
ENV QTH KA12aa
ENV NAME "Mr. X"
ENV SQUARE KA12aa

EXPOSE 7373
EXPOSE 7301
EXPOSE 9001

ENTRYPOINT ["startup.sh"]
CMD ["/usr/bin/supervisord"]

