# === EC2 + Auto Scaling Group (Privadas) ===

resource "aws_launch_template" "nginx" {
  name_prefix   = "nginx-launch-"
  image_id      = "ami-0c2b8ca1dad447f8a"
  instance_type = "t3.micro"

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [aws_security_group.ec2_sg.id]
  }

  user_data = base64encode(<<EOF
#!/bin/bash
yum update -y
amazon-linux-extras install nginx1 -y
systemctl start nginx
systemctl enable nginx
echo "Hola desde EC2 a través del ALB" > /usr/share/nginx/html/index.html
EOF
  )
}

resource "aws_autoscaling_group" "nginx" {
  desired_capacity     = 2
  max_size             = 2
  min_size             = 2
  vpc_zone_identifier  = [aws_subnet.private_1.id, aws_subnet.private_2.id]
  target_group_arns    = [aws_lb_target_group.main.arn]

  launch_template {
    id      = aws_launch_template.nginx.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "nginx-instance"
    propagate_at_launch = true
  }

  health_check_type         = "EC2"
  health_check_grace_period = 60
}
