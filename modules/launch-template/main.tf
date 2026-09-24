resource "aws_launch_template" "this" {
  name_prefix   = "${var.name}-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = var.security_group_ids

  user_data = base64encode(<<-EOF
    #!/bin/bash

    apt-get update -y
    apt-get install -y nginx

    systemctl enable nginx
    systemctl start nginx

    cat > /var/www/html/index.html <<EOF
    <h1>This is Tushar's demo Project</h1>
    <p>Deployed by Terraform Auto Scaling Group</p>
    <p>Hello from $(hostname)</p>
    EOF
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