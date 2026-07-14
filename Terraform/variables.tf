variable "aws_region" {
  default = "ap-south-1"
}

variable "project_name" {
  default = "three-tier"
}

variable "environment" {
  default = "dev"
}

variable "cluster_version" {
  default = "1.31"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnets" {

  type = list(string)

  default = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]
}

variable "private_subnets" {

  type = list(string)

  default = [
    "10.0.11.0/24",
    "10.0.12.0/24"
  ]
}

variable "instance_type" {
  default = "t3.medium"
}

variable "desired_size" {
  default = 2
}

variable "min_size" {
  default = 2
}

variable "max_size" {
  default = 4
}

variable "key_name" {
  description = "AWS EC2 Key Pair Name"
  type        = string
}
