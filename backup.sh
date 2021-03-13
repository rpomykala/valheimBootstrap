#!/bin/bash

export LOCAL_BACKUP_DIR=
export S3_BUCKET_NAME=
export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=

exec >>/var/log/backup.log 2>>/var/log/backup.err.log

now=$(date +%s)
backup_filename="valheim-backup.tar.bz2.$now"
cd ~

echo $backup_filename
cp valheim-backup.tar.bz2 $backup_filename && rm valheim-backup.tar.bz2
mv $backup_filename $LOCAL_BACKUP_DIR &
tar -cvjSf valheim-backup.tar.bz2 ~/.config/unity3d/IronGate/Valheim/worlds
sleep 10
aws configure set default.s3.max_bandwidth 100KB/s
aws s3 cp ~/Valheim/valheim-backup.tar.bz2 s3://$S3_BUCKET_NAME