module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.77.0"

  name = "${var.vpc_name} - ${terraform.workspace}"
  cidr = var.vpc_cidr

  azs             = var.vpc_azs
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets

  enable_ipv6          = var.vpc_enable_ipv6
  enable_nat_gateway   = var.vpc_enable_nat_gateway
  single_nat_gateway   = var.vpc_single_nat_gateway
  enable_dns_support   = var.vpc_enable_dns_support
  enable_dns_hostnames = var.vpc_enable_dns_hostnames

  tags = merge(var.common_tags, var.vpc_tags)
}
