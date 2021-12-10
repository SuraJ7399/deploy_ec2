provider "aws" {

region = "ap-south-1"

}

resource "aws_instance" "ubuntu" {

ami = "ami-052cef05d01020f1d"
instance_type = "t2.micro"
key_name = "PEM"

}
resource "aws_eip" "elastic_ip" {
instance = aws_instance.ubuntu.id
}

output "EIP" {
value = aws_eip.elastic_ip.public_ip
}
