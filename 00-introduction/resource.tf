provider "aws" {
}

variable "AWS_REGION" {
  type    = string
  default = "us-east-1"
}

variable "AMIS" {
  type    = map(string) 
    default = {
      eu-west-1 = "ami-000001"
  }
}

resource "aws_instance" "example" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.nano"
}
