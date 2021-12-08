provider "aws" {
  region     = "ap-northeast-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0218d08a1f9dac831"
  instance_type = "t2.micro"
}
resource "aws_launch_template" "foobar" {
  name_prefix   = "foobar"
  image_id      = "ami-1a2b3c"
  instance_type = "t2.micro"
}

resource "aws_autoscaling_group" "bar" {
  availability_zones = ["ap-northeast-1"]
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1

  launch_template {
    id      = aws_launch_template.foobar.id
    version = "$Latest"
  }
}
