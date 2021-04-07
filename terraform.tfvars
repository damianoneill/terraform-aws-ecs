aws_region="us-west-2"
vpc_name="terraform_aws_ecs"
vpc_azs=["us-west-2a"]
vpc_private_subnets=["10.0.1.0/24"]
vpc_public_subnets=["10.0.101.0/24"]
aws_ecr_repository_repositories={
    bash = {
      aws_ecr_repository_name = "bash",
      source_image_name       = "bash",
      source_image_tag        = "5.1.4"
    }
}