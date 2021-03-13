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
# Make sure that the server name is identical to the filename of your backup SERVER_NAME.db and SERVER_NAME.fml if you are
# importing an existing world. Place those files inside ~/.config/unity3d/IronGate/Valheim/worlds
export SERVER_NAME=
export PROXY_URL=
```

```
./install.sh
```

# Installing reverse proxy

⚠ Replace both "password" fields for reverse proxy mr2_linux_amd64 in both start_valheim.sh and main.tf user_data

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

Make sure to replace following variables in backup.sh script

```
export LOCAL_BACKUP_DIR=
export S3_BUCKET_NAME=
export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=
```