resource "aws_autoscaling_group" "ondemand" {
  name                 = var.aws_autoscaling_group_name
  vpc_zone_identifier  = module.vpc.private_subnets
  max_size             = var.aws_autoscaling_group_max_size
  min_size             = var.aws_autoscaling_group_min_size
  desired_capacity     = var.aws_autoscaling_group_desired_capacity
  launch_configuration = aws_launch_configuration.ondemand.name

  tag {
    key   = "Name"
    value = var.aws_ecs_cluster_name

    # Make sure EC2 instances are tagged with this tag as well
    propagate_at_launch = true
  }

  dynamic "tag" {
    for_each = var.common_tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

resource "aws_launch_configuration" "ondemand" {
  name              = var.aws_launch_configuration_name
  image_id          = data.aws_ami.ecs.id
  instance_type     = var.aws_launch_configuration_instance_type
  enable_monitoring = true
  # associate_public_ip_address = true
  user_data = <<EOF
#!/bin/bash
echo ECS_CLUSTER=${var.aws_ecs_cluster_name} >> /etc/ecs/ecs.config
echo ECS_INSTANCE_ATTRIBUTES={\"purchase-option\":\"ondemand\"} >> /etc/ecs/ecs.config
EOF
  security_groups = [
    aws_security_group.ec2_instances.id
  ]
  key_name             = var.aws_launch_configuration_key_name
  iam_instance_profile = aws_iam_instance_profile.ec2_iam_instance_profile.arn
}

resource "aws_security_group" "ec2_instances" {
  name        = var.aws_security_group_name
  description = "Security group for EC2 instances within the cluster"
  vpc_id      = module.vpc.vpc_id
  tags = merge(
    var.common_tags,
    { Workspace = terraform.workspace }
  )
}