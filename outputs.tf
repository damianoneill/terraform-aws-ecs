output "terraform_workspace" {
  description = "Terraform workspace used to provision aws"
  value       = terraform.workspace
}

# output "ec2_instance_public_ips" {
#   description = "Public IP addresses of EC2 instances"
#   value       = module.ec2_instances.public_ip
# }