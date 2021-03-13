#!/bin/bash

export templdpath=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=./linux64:$LD_LIBRARY_PATH
export SteamAppId=892970

# Make sure that the server name is identical to the filename of your backup SERVER_NAME.db and SERVER_NAME.fml if you are
# importing an existing world. Place those files inside ~/.config/unity3d/IronGate/Valheim/worlds
export SERVER_NAME=
export PROXY_URL=

# Tip: Make a local copy of this script to avoid it being overwritten by steam.
# NOTE: Minimum password length is 5 characters & Password cant be in the server name.
# NOTE: You need to make sure the ports 2456-2458 is being forwarded to your server through your local router & firewall.
~/.steam/steamcmd/steamcmd.sh +login anonymous +force_install_dir ~/Valheim +app_update 896660 +quit

# Make sure to change the password and only give it to friends that you want to connect to your server
export CLIENT_PASSWORD=
./valheim_server.x86_64 -name $SERVER_NAME -port 2456 -world $SERVER_NAME -password $CLIENT_PASSWORD -public 1 > /dev/null &

./mr2_linux_amd64 client -s $PROXY_URL -p "backend_password" -P 2456 -c 127.0.0.1:2456 &

export LD_LIBRARY_PATH=$templdpath

echo "Server started"
echo ""
#read -p "Press RETURN to stop server"
#echo 1 > server_exit.drp

#echo "Server exit signal set"
#echo "You can now close this terminal"

while :
do
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
echo "valheim.service: timestamp ${TIMESTAMP}"
sleep 60
done