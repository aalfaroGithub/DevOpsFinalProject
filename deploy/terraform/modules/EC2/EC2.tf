# RSA key of size 4096 bits
resource "tls_private_key" "rsa_4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  //public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 email@example.com"
  public_key = tls_private_key.rsa_4096.public_key_openssh                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
}

resource "local_file" "private_key" {
    content  = tls_private_key.rsa_4096.private_key_pem
    // save the file on user directory /ansible/key_name.pem
    # filename = "/Documents/ansible/${var.key_name}"
    filename = "${pathexpand("~")}/Documents/ansible/${var.key_name}.pem"
    //filename = var.key_name
}

resource "aws_instance" "public_instance" {
  ami                  = var.ami
  availability_zone    = var.availability_zone
  instance_type        = var.instance_type
  security_groups      = [var.app_security_group]
  subnet_id            = var.public_subnet_id
  key_name             = aws_key_pair.key_pair.key_name
  iam_instance_profile = var.instance_profile
  
  tags = {
    Name = "public_instance"
  }
}