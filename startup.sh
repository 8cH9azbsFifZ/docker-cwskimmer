#!/bin/bash
set -e 

echo "Start sink for CAT port"
socat PTY,link=/dev/cat TCP:$RIGSERVER:$RIGSERVER_CAT_PORT &
socat PTY,link=/dev/ptt TCP:$RIGSERVER:$RIGSERVER_PTT_PORT &


echo "Configure Pulseaudio for remote access"
#pulseaudio -k
cat << eof >> /etc/pulse/default.pa 
load-module module-tunnel-sink-new server=$RIGSERVER sink_name=RemoteOut
load-module module-tunnel-source-new server=$RIGSERVER source_name=RemoteIn
eof
sync;sync;sync;sync;sync
echo "Starting Pulseaudio"
pulseaudio --start

sleep 5

exec "$@"
