resource "aws_launch_template" "this" {
  name_prefix   = "${var.name}-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = var.security_group_ids

  iam_instance_profile {
    name = var.iam_instance_profile_name
  }

  user_data = base64encode(<<-USERDATA
    #!/bin/bash
    set -e
    apt-get update
    apt-get install -y nginx

    systemctl enable nginx
    systemctl start nginx

    echo "<h1>This is Tushar's demo Project</h1>" > /var/www/html/index.html
    echo "<p>Deployed by Terraform Auto Scaling Group</p>" >> /var/www/html/index.html
    echo "<p>Hello from $(hostname)</p>" >> /var/www/html/index.html
  USERDATA
  )

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