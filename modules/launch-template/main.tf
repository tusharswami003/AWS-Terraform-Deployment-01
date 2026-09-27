resource "aws_launch_template" "this" {
  name_prefix   = "${var.name}-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = var.security_group_ids

  iam_instance_profile {
    name = var.iam_instance_profile_name
  }

  user_data = base64encode(var.user_data)
    
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = var.name
    }
  }

  tags = {
    Name = var.name
  }
}