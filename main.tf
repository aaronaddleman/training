#
# DO NOT DELETE THESE LINES!
#
# Your subnet ID is:
#
#     subnet-ddd57685
#
# Your security group ID is:
#
#     sg-29ef374e
#
# Your AMI ID is:
#
#     ami-30217250
#
# Your Identity is:
#
#     autodesk-ant
#

# variables
variable "aws_access_key" {
  type = "string"
}

variable "aws_secret_key" {
  type = "string"
}

variable "aws_region" {
  type    = "string"
  default = "us-west-1"
}

variable "aws_ami" {
  type    = "string"
  default = "ami-30217250"
}

variable "web_count" {
  default = "3"
}

# provider
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

# resources
resource "aws_instance" "web" 
  count         = "${var.web_count}"
  ami           = "${var.aws_ami}"
  instance_type = "t2.micro"

  subnet_id = "subnet-ddd57685"

  vpc_security_group_ids = [
    "sg-29ef374e",
  ]

  tags {
    Identity = "autodesk-ant"
    Company  = "autodesk"
    Animal   = "ant"
    Name     = "web ${count.index+1}/${var.web_count}"
  }
}

output "public_dns" {
  value = ["${aws_instance.web.*.public_dns}"]
}

output "public_ip" {
  value = ["${aws_instance.web.*.public_ip}"]
}

