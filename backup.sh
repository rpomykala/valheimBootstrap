#!/bin/bash

export LOCAL_BACKUP_DIR=
export S3_BUCKET_NAME=
export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=

exec >>/var/log/backup.log 2>>/var/log/backup.err.log

#!/bin/bash
exec >>/var/log/backup.log 2>>/var/log/backup.err.log
export AWS_CONFIG_FILE="/home/username/.aws/config"


now=$(date +%s)
backup_filename="valheim-backup.tar.bz2.$now"
cd ~
echo $backup_filename
tar -cvjSf $backup_filename ~/.config/unity3d/IronGate/Valheim/worlds
mv $backup_filename /mnt/hdd/samba/ &
rm valheim-backup.tar.bz2
mv $backup_filename valheim-backup.tar.bz2
sleep 10
/usr/local/bin/aws configure set default.s3.max_bandwidth 100KB/s
/usr/local/bin/aws s3 mv ~/valheim-backup.tar.bz2 s3://$S3_BUCKET_NAME
/usr/local/bin/aws s3api put-object-acl --bucket $S3_BUCKET_NAME --key valheim-backup.tar.bz2 --acl public-read