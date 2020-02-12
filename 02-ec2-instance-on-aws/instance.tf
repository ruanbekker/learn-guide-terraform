provider "aws" {
  access_key = ""
  secret_key = ""
  region     = "eu-west-1"
}

resource "aws_instance" "example" {
  ami           = "ami-07042e91d04b1c30d"
  instance_type = "t2.micro"
}
