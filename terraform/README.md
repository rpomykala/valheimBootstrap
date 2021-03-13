# Creating a proxy

We don't want to directly expose your game server to internet traffic, that's why we're creating a proxy in AWS.
You can certainly use a free tier of AWS for this as the only thing you'll be paying here is bandwidth and i/o requirements are not very high.

Guides on how to create an account:

https://kangzeroo.medium.com/creating-your-aws-account-72fb95a3f1bb

## Terraform

You don't need to install Terraform but it helps in automating the process. If you'd rather install the proxy yourself, 
here's a guide on how to start your own server (until the Apache PHP part -- you don't need that)

https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Tutorials.WebServerDB.CreateWebServer.html

## Proxy software

This is the important part in running your proxy: you'll need to install mr2 which can help you expose local servers to external network.
We'll configure the server here

```
# Getting dependencies Golang 1.13+ and git
sudo apt get install go git
# Using my fork, only change it if you know what you're doing
git clone https://github.com/rpomykala/mr2 && cd mr2
go get 
cd cli/mr2
go get
GOOS=linux GOARCH=amd64 go build -o mr2_linux_amd64
cp mr2_linux_amd64 ~
# Make sure to change this password to backend_password you set in start_valheim.sh file
nohup mr2_linux_amd64 server -l 2456 -p "backend_password"

```

If your server is runing correctly then copy the instance's IP address and connect to it in-game with ipaddress:2456