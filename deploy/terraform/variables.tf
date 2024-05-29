variable "ami" {
  description = "The AMI to use for the instance"
  type        = string
  default = "ami-0cf2b4e024cdb6960"
}

variable "instance_type" {
  description = "The type of instance to launch"
  type        = string
  default = "t2.micro"
}

variable "vpc_id" {
  description = "The VPC ID"
  type        = string
  default = "vpc-0d807c53ac9514d59"
}

variable "subnet_id" {
  description = "The Subnet ID"
  type        = string
  default = "subnet-089a9a90b7fb9d9b2"
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
}

variable "region" {
  description = "The region to launch the instance"
  type        = string
  default = "us-west-2" 
}