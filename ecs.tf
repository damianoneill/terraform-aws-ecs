resource "aws_ecs_cluster" "default" {
  name = var.aws_ecs_cluster_name
  tags = merge(
    var.common_tags,
    {},
  )
}
