#!/bin/bash
#set d -e 

echo "Configure Skimmer with Callsign: $CALLSIGN, QTH: $QTH, Name: $NAME, Grid: $SQUARE using $PATH_INI_SKIMSRV"
sed -i 's/Call=/Call='$CALLSIGN'/g' "$PATH_INI_SKIMSRV"
sed -i 's/QTH=/QTH='$QTH'/g' "$PATH_INI_SKIMSRV"
sed -i 's/Name=/Name='$NAME'/g' "$PATH_INI_SKIMSRV"
sed -i 's/Square=/Square='$SQUARE'/g' "$PATH_INI_SKIMSRV"

echo "Configure RBN Aggregator with Callsign: $CALLSIGN using $PATH_INI_AGGREGATOR"
#sed -i 's/Skimmer Call=.*/Skimmer Call='$CALLSIGN'/g' "$PATH_INI_AGGREGATOR"
#cat "$PATH_INI_AGGREGATOR"
sed -i 's/CW0SKIM/'$CALLSIGN'/g' "$PATH_INI_AGGREGATOR"
#cat "$PATH_INI_AGGREGATOR"
# FIXME: only debug stuff
cp "$PATH_INI_AGGREGATOR" /root/
chmod oag-r "$PATH_INI_AGGREGATOR"


echo "Configure Hermes DLL for ${IP_HERMES}"
cp /HermesDLL_${V_HERMES}/HermesIntf.dll /skimmersrv_${V_SKIMMERSRV}/app/HermesIntf_${IP_HERMES}.dll

echo "Configure supervisor for aggregator ${V_RBNAGGREGATOR}"
sed -i 's/6\.3/'$V_RBNAGGREGATOR'/g' /etc/supervisor/conf.d/supervisord.conf

echo "Configure supervisor for skimmer ${V_SKIMMERSRV}"
sed -i 's/1\.6/'$V_SKIMMERSRV'/g' /etc/supervisor/conf.d/supervisord.conf


## Disabled: support for network sound

#echo "Start sink for CAT port"
#socat PTY,link=/dev/cat TCP:$RIGSERVER:$RIGSERVER_CAT_PORT &
#socat PTY,link=/dev/ptt TCP:$RIGSERVER:$RIGSERVER_PTT_PORT &


#echo "Configure Pulseaudio for remote access"
#pulseaudio -k
#cat << eof >> /etc/pulse/default.pa 
#load-module module-tunnel-sink-new server=$RIGSERVER sink_name=RemoteOut
#load-module module-tunnel-source-new server=$RIGSERVER source_name=RemoteIn
#eof
#sync;sync;sync;sync;sync
#echo "Starting Pulseaudio"
#pulseaudio --start

#sleep 5

exec "$@"
