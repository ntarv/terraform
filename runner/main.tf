provider "aws" {
  access_key = ""
  secret_key = ""
  region     = "eu-central-1"
}


resource "aws_instance" "Runner" {
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.runner.id]
  user_data                   = file("runnerup.sh")
  user_data_replace_on_change = true
  key_name                    = "runner"
  ami                         = "ami-0d1ddd83282187d18"
  tags                        = {
    Name  = "Runner_Github"
    "ENV" = "production"

  }
}

resource "aws_security_group" "runner" {
  name        = "allow_all"
  description = "Allow all inbound traffic"

  dynamic "ingress" {
    for_each = ["80", "443", "22", "8080", "8000", "8822"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}

resource "aws_key_pair" "runner" {
      key_name   = "runner"
      public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDAQgAvuo2gbDtFSiKxovB7xLmonHEZjvLMkbBoIq6ONjJXD4w1THPgcsvPqvnHkSEfD6VbyHhT2qx2jslZPzWDwQ+Tdq1avMvoB4Ddeilfdgz59wZzx7PXKQ2divrTCOxUCKR/xYSsthd60Y6YuLcRs+8oKevANrI9jRz0FvilBjt2+Nf9MfSm+l6OkFF8eHhhyq+W7r6MPGqa82EUOGl6fjxoo5rMkKjSldADqhFZKwp52EXVcS2jok+gJOIM0ub8+M+V8LwNtAZg9GQC6fClARNdWUdR9pnr+1Ud1gSROlhes8EwIy+pER7xreNxlcu0F0Qp5DT62SBu93XDBoXTIuq7SkXm2IB7lmEQ/6w1LfxLYeu343lIQk7LMHe12UWPj8YbMVnIVo7GxGyTzSe+goDdQw9YrHhB+0C2iHgcPOqAYVbMq59PLYd0gDUz2e8iLShV9IqgDdL0Pn9uqpasU1hLWdbSh4bVrmEtYJuvFsx2r4BvQl8OWMYpdlY7hY8= emea\\ilteltano@ILTELPC228"

    }





