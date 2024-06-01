variable "environment" {
  description = "The environment to launch the instance"
  type        = string
  
}

variable "ami" {
  description = "The AMI to use for the instance"
  type        = string
  default = "ami-0cf2b4e024cdb6960"
}

variable "instance_type" {
  description = "The type of instance to launch"
  type        = string
  default = "t2.large"
}

variable "availability_zone" {
  description = "The availability zone to launch the instance"
  type        = string
  
}

variable "app_security_group" {
  description = "The security group for the instance"
  type        = string
  
}

variable "public_subnet_id" {
  description = "The public subnet ID"
  type        = string
}

variable "private_subnet_id" {
  description = "The private subnet ID"
  type        = string
  
}

variable "instance_profile" {
  description = "The instance profile for the instance"
  type        = string

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

// variable key_name.pem location
variable "private_key_path" {
  description = "The path to save the private key"
  type        = string
  default     = "/Documents/ansible/"
  
}