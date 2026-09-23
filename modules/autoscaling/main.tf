resource "aws_autoscaling_group" "this" {
  name = var.name

  min_size         = var.min_size
  desired_capacity = var.desired_capacity
  max_size         = var.max_size

  vpc_zone_identifier = var.subnet_ids
  target_group_arns   = var.target_group_arns

  health_check_type         = "ELB"
  health_check_grace_period = 120

  launch_template {
    id      = var.launch_template_id
    version = var.launch_template_version
  }

  tag {
    key                 = "Name"
    value               = var.name
    propagate_at_launch = true
  }
}