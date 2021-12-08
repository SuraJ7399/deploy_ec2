provider "aws" {
   region     = "ap-northeast-1"
   access_key = "AKIASIP36E5FHIZE7FCB"
   secret_key = "6VHENbWpo6a8LKAnVwSiORpsO8Es9ut8IzeU59Dq"
   
}

resource "aws_instance" "ec2_example" {

    ami = "ami-0218d08a1f9dac831"  
    instance_type = "t2.micro" 
    key_name= "keyfile"
    vpc_security_group_ids = [aws_security_group.main.id]

  provisioner "remote-exec" {
    inline = [
      "touch hello.txt",
      "echo helloworld remote provisioner >> hello.txt",
    ]
  }
  connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("/c/Users/20323725/Downloads/deploy_key")
      timeout     = "4m"
   }
}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
 ingress                = [
   {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 22
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 22
  }
  ]
}


resource "aws_key_pair" "deployer" {
  key_name   = "keyfile"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC2fy2KvAGqtXJsrsGAqAsr3X9EbWIYXLBGdWetyfRwYFxft5hi5dQkct/msP6H9W00OzpFVmzHFrwJNTckYPP/yoWXTP+DSYZcLY9nAWQlRh5BXQ/gLdv/Rpe7wkA3WhqmJJcLl
9B4DoiJuZSF6TemttXSiyAFXsSnfpT4Zg0rjd+X7fBwhm+M4Pb6+yVXi05FbEgopFFCBzivOG9vnRPAyb2SNWD1mvPS93nL7h3HKVhza6eQ5bfOSVag2vI+l1Nnv+kFbGQT3hnUjrBpmZZbq4cnjMF2opqyMEJQAAJbbQLy/A3tcY
NF38011leLvqEKilkBwX5P4QNVTrFGkT/r ec2-user@ip-172-31-32-20.ap-south-1.compute.internal"
}
