#!/bin/bash
set -e

if ! [ -x "$(command -v git)" ]; then
  echo 'Error: git is not installed.' >&2
  exit 1
fi

if ! [ -x "$(command -v go)" ]; then
  echo 'Error: golang is not installed.' >&2
  exit 1
fi

if ! [ -x "$(command -v steamcmd)" ]; then
  echo 'Error: golang is not installed.' >&2
  exit 1
fi

if ! [ -x "$(command -v aws)" ]; then
  echo 'Warning: AWS CLI is not installed. Automatic backups will not be possible' 
fi

username=$(whoami)

# Permission for backup logs

sudo touch /var/log/backup.log
sudo touch /var/log/backup.err.log
sudo chown $username:$username /var/log/backup.err.log
sudo chown $username:$username /var/log/backup.log
sed -i "s/username/$username/g" backup.sh


# Installing SteamCMD https://developer.valvesoftware.com/wiki/SteamCMD

cd ~ && mkdir Valheim
.steam/steamcmd/steamcmd.sh +login anonymous +force_install_dir ~/Valheim +app_update 896660 validate +exit
cp start_valheim.sh ~/Valheim/

# Installing reverse proxy

git clone https://github.com/rpomykala/mr2 && cd mr2
go get 
cd cli/mr2
go get
GOOS=linux GOARCH=amd64 go build -o mr2_linux_amd64
cp mr2_linux_amd64 ~

# Creating a valheim Service
sed -i "s/username/$username/g" valheim.service
sed -i "s/username/$username/g" proxyreverse.service
sudo cp proxyreverse.service /etc/systemd/system
sudo cp valheim.service /etc/systemd/system
sudo systemctl enable valheim.service && sudo systemctl start valheim.service
sudo systemctl status valheim.service > valheim.service.log
sudo systemctl enable proxyreverse.service && sudo systemctl start proxyreverse.service
sudo systemctl status proxyreverse.service > proxyreverse.service.log

