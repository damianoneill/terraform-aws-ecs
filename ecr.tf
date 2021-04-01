resource "aws_ecr_repository" "repositories" {
  for_each = var.aws_ecr_repository_repositories
  name     = each.value.aws_ecr_repository_name
  tags = merge(
    var.common_tags,
    var.aws_ecr_repository_tags,
    { Workspace = terraform.workspace }
  )
}
