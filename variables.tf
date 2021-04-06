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
