provider "aws" {
    region     = "us-east-1"
  }

  resource "aws_instance" "ubuntu" {
    ami           = "ami-083654bd07b5da81d"
    instance_type = "t2.micro"
    key_name = "PEM"
  }

  resource "aws_eip" "elastic_ip" {
    instance = aws_instance.ubuntu.id
  }

  output "EIP" {
    value = aws_eip.elastic_ip.public_ip
  }
