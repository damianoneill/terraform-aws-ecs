
resource "aws_iam_instance_profile" "ec2_iam_instance_profile" {
  role = aws_iam_role.ec2_role.name
}

resource "aws_iam_role" "ec2_role" {
  assume_role_policy = data.aws_iam_policy_document.ecs_role_definition.json

  # Allows the role to be deleted and reacreated (when needed)
  force_detach_policies = true
  tags = merge(
    var.common_tags,
    {},
  )
}

data "aws_iam_policy_document" "ecs_role_definition" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole",
    ]
    principals {
      identifiers = [
        "ec2.amazonaws.com",
        "ecs-tasks.amazonaws.com"
      ]
      type = "Service"
    }
  }
}
