# valheimBootstrap

![diagram](./assets/diagram.png)

# Pre-requisites

SteamCMD

https://developer.valvesoftware.com/wiki/SteamCMD#Linux

```
useradd -m steam
sudo add-apt-repository multiverse
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install lib32gcc1 steamcmd 
 ```

Go 1.13+

```
wget https://dl.google.com/go/go1.13.9.linux-amd64.tar.gz
tar xf go1.13.9.linux-amd64.tar.gz
sudo mv go /usr/local/go
echo "export GOROOT=/usr/local/go" >> $HOME/.bashrc
echo "export PATH=$GOROOT/bin:$PATH" >> $HOME/.bashrc
source ~/.bashrc
which go
```

Terraform (to create a UDP proxy in AWS)

```
wget https://releases.hashicorp.com/terraform/0.14.7/terraform_0.14.7_linux_amd64.zip
unzip terraform_0.14.7_linux_amd64.zip
sudo mv terraform /usr/local/bin/
terraform -version
```

# Installing the server

Replace following variables in the install.sh script

```
# Important info if you are importing an existing world: 
# Make sure that the server name is identical to the filename of your backup SERVER_NAME.db and SERVER_NAME.fml
# Place those files inside ~/.config/unity3d/IronGate/Valheim/worlds
# If this is a new server, give it a unique name.
export SERVER_NAME=
export PROXY_URL=

# Make sure to change the password and only give it to friends that you want to connect to your server
export CLIENT_PASSWORD=

```

```
./install.sh
```

# Installing reverse proxy

⚠ Replace both "backend_password" fields for reverse proxy mr2_linux_amd64 in both start_valheim.sh and main.tf user_data

For more details [click here](https://github.com/rpomykala/valheimBootstrap/blob/main/terraform/README.md)

```
aws configure
cd ./terraform && terraform init && terraform plan
terraform apply
```

### Automatic backups

Create an IAM user

https://docs.easydigitaldownloads.com/article/1455-amazon-s3-creating-an-iam-user

AWS CLI 

```
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```


```
crontab -e
```

Add following line at the end of the file

```
0 */6 * * * /home/<your_username>/backup.sh
```

Make sure to replace following variables in backup.sh script

```
export LOCAL_BACKUP_DIR=
export S3_BUCKET_NAME=
export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=
```