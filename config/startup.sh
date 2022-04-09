#!/bin/bash
#set d-e 

echo "Configure Skimmer with Callsign: $CALLSIGN and QTH: $QTH using $PATH_INI_SKIMSRV"
sed -i 's/Call=/Call='$CALLSIGN'/g' "$PATH_INI_SKIMSRV"
sed -i 's/QTH=/QTH='$QTH'/g' "$PATH_INI_SKIMSRV"


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
