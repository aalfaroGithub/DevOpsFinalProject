variable "vpc_id" {
  description = "The VPC ID"
  type        = string
  default = "vpc-0d807c53ac9514d59"
}

# variable "public_subnet_id" {
#   description = "The public subnet ID"
#   type        = string
#   default = "subnet-089a9a90b7fb9d9b2"
# }

variable "availability_zone_public" {
  description = "The availability zone for the public subnet"
  type        = string
  default = "us-west-2a"
  
}

variable "availability_zone_private" {
  description = "The availability zone for the private subnet"
  type        = string
  default = "us-west-2b"
  
}

variable "ports" {
  description = "The ports to open in the security group"
  type        = list(number)
  default = [22, 80, 443, 8080, 9000]
  
}