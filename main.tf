provider "aws" {

region = "us-east-1"

}

resource "aws_instance" "ubuntu" {

ami = "ami-083654bd07b5da81d"
instance_type = "t2.micro"
key_name = "PEM"

}
resource "aws_eip" "elastic_ip" {

instance = aws_instance.ubuntu.id

}

resource "aws_security_group" "allow_ssh" {

name = "allow_ssh"

ingress {

description = "ssh from VPC"
from_port = 22
to_port = 22
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}
