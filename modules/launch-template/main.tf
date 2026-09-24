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

  HOSTNAME=$(hostname)
  PRIVATE_IP=$(hostname -I | awk '{print $1}')

  cat > /var/www/html/index.html <<HTML
  <!DOCTYPE html>
  <html>
  <head>
      <title>Tushar Cloud Project</title>
      <style>
          body {
              background: #0d1117;
              color: #c9d1d9;
              font-family: Arial, sans-serif;
              text-align: center;
              padding-top: 70px;
          }

          h1 {
              font-size: 48px;
              color: #58a6ff;
          }

          .card {
              background: #161b22;
              width: 550px;
              margin: auto;
              padding: 30px;
              border-radius: 15px;
              box-shadow: 0 0 25px rgba(88,166,255,0.2);
          }

          .status {
              color: #3fb950;
              font-size: 22px;
              font-weight: bold;
          }

          .server {
              background: #0d1117;
              padding: 15px;
              margin-top: 20px;
              border-radius: 8px;
              font-family: monospace;
          }

          .small {
              color: #8b949e;
              margin-top: 30px;
          }
      </style>
  </head>

  <body>

      <h1>&#9729;&#65039; Tushar Cloud Operations Center  &#9729;&#65039;</h1>

      <div class="card">

          <p class="status">&#128994; SYSTEM IS SOMEHOW WORKING</p>

          <h2>Congratulations &#127881;</h2>

          <p>
              You have successfully reached an EC2 instance
              hiding somewhere inside a private subnet.
          </p>

          <div class="server">
              Server: $HOSTNAME
              <br>
              Private IP: $PRIVATE_IP
          </div>

          <p>
              Your request survived:
          </p>

          <p>
              Internet &#127757;
              → ALB
              → Target Group
              → Auto Scaling Group
              → EC2
              → NGINX
          </p>

          <p>
              NAT Gateway bill is also successfully running. &#128184; &#128184; &#128184;
          </p>

          <p class="small">
              Infrastructure deployed with Terraform.<br>
              Servers harmed during debugging: several.
          </p>

      </div>

  </body>
  </html>
  HTML

  systemctl enable nginx
  systemctl restart nginx
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