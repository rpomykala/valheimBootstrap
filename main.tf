provider "aws" {
    region = "eu-west-1"
}
resource "aws_instance" "cie_udp_proxy" {
    ami           = "ami-08bac620dc84221eb"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.allow_udp_tcp.id]
    user_data = <<-EOF
                #!/bin/bash
                sudo apt get install go git
                git clone https://github.com/rpomykala/mr2 && cd mr2
                go get 
                cd cli/mr2
                go get
                GOOS=linux GOARCH=amd64 go build -o mr2_linux_amd64
                cp mr2_linux_amd64 ~
                nohup mr2_linux_amd64 server -l 2456 -p password
                EOF

}

resource "aws_security_group" "allow_udp_tcp" {
    name        = "allow_game_traffic"
    description = "Allow UDP & TCP inbound traffic"

    ingress {
        description = "UDP from VPC"
        from_port   = 2456
        to_port     = 2456
        protocol    = "udp"
        cidr_blocks = ["0.0.0.0/0"]
    }  
    ingress {
        description = "tcp from VPC"
        from_port   = 2456
        to_port     = 2456
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    } 
    tags = {
        Name = "allow_udp"
    }
}
