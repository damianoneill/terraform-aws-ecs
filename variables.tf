variable "aws_region" {
  description = "The AWS region to launch the cluster and related resources"
  type        = string
}

variable "common_tags" {
  description = "Common resource tags"
  type        = map(string)
  default = {
    Terraform   = "true"
    Environment = "dev"
  }
}

###############
# VPC Variables
###############
variable "vpc_name" {
  description = "Name of VPC"
  type        = string
  default     = "example-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_azs" {
  description = "Availability zones for VPC"
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

variable "vpc_private_subnets" {
  description = "Private subnets for VPC"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "vpc_public_subnets" {
  description = "Public subnets for VPC"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "vpc_enable_ipv6" {
  description = "Enable IPv6 for VPC"
  type        = bool
  default     = false
}

variable "vpc_enable_nat_gateway" {
  description = "Enable NAT gateway for VPC"
  type        = bool
  default     = true
}

variable "vpc_single_nat_gateway" {
  description = "Enable Single NAT gateway for VPC"
  type        = bool
  default     = true
}

variable "vpc_enable_dns_support" {
  description = "Enable DNS support for VPC"
  type        = bool
  default     = true
}

variable "vpc_enable_dns_hostnames" {
  description = "Enable DNS Hostname for VPC"
  type        = bool
  default     = true
}

variable "vpc_tags" {
  description = "Tags to apply to resources created by VPC module"
  type        = map(string)
  default     = {}
}


####################
# ECR Variables
####################

# repo structure should include the repository_name, source image name and tag
variable "aws_ecr_repository_repositories" {
  description = "Map of ECR repositories to create"
  type        = map(any)
  default = {
    repo1 = {
      aws_ecr_repository_name = "repository1",
      source_image_name       = "bash",
      source_image_tag        = "latest"
    }
  }
}

variable "aws_ecr_repository_tags" {
  description = "Tags to apply to resources created by ECR Repository module"
  type        = map(string)
  default     = {}
}

variable "aws_ecs_cluster_name" {
  description = "The name of the ecs cluster (up to 255 letters, numbers, hyphens, and underscores)"
  type        = string
}

####################
# EC2 Variables
####################

variable "aws_launch_configuration_key_name" {
  description = "The name an aws ssh key that can be used with the ec2 instances"
  type        = string
}

variable "aws_autoscaling_group_name" {
  description = "The name of the autoscaling group"
  type        = string
  default     = "ondemand"
}

variable "aws_autoscaling_group_max_size" {
  description = "The max number of ec2 instances in the autoscaling group"
  type        = string
  default     = "2"
}

variable "aws_autoscaling_group_min_size" {
  description = "The min number of ec2 instances in the autoscaling group"
  type        = string
  default     = "2"
}

variable "aws_autoscaling_group_desired_capacity" {
  description = "The desired number of ec2 instances in the autoscaling group"
  type        = string
  default     = "2"
}

variable "aws_launch_configuration_name" {
  description = "The name of the launch configuration"
  type        = string
  default     = "ondemand"
}

variable "aws_launch_configuration_instance_type" {
  description = "The instance type for the launch configuration"
  type        = string
  default     = "t3.micro"
}

variable "aws_security_group_name" {
  description = "The name of the aws security group"
  type        = string
  default     = "ondemand"
}