#!/bin/bash
export PROXY_URL=:3000
./mr2_linux_amd64 client -s $PROXY_URL -p password -P 2456 -c 127.0.0.1:2456
echo "Server started"
echo ""
#read -p "Press RETURN to stop server"
#echo 1 > proxy_server_exit.drp

#echo "Server exit signal set"
#echo "You can now close this terminal"

while :
do
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
echo "proxyreverse.service: timestamp ${TIMESTAMP}"
sleep 60
done