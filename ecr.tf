resource "aws_ecr_repository" "repositories" {
  for_each = var.aws_ecr_repository_repositories
  name     = each.value.aws_ecr_repository_name
  tags = merge(
    var.common_tags,
    var.aws_ecr_repository_tags,
    { Workspace = terraform.workspace }
  )
}

data "aws_caller_identity" "current" {}

resource "null_resource" "push" {
  for_each = var.aws_ecr_repository_repositories
  provisioner "local-exec" {
    command     = "${coalesce("scripts/tagandpush.sh", "${path.module}/scripts/tagandpush.sh")} ${each.value.source_image_name}:${each.value.source_image_tag} ${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/${each.value.aws_ecr_repository_name}:${each.value.source_image_tag}"
    interpreter = ["bash", "-c"]
  }
  depends_on = [
    aws_ecr_repository.repositories
  ]
}
