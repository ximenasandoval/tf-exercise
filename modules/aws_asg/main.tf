resource "aws_autoscaling_group" "main" {
  name                = var.name
  max_size            = var.asg_max_size
  min_size            = var.asg_min_size
  desired_capacity    = var.asg_desired_capacity
  default_cooldown    = var.asg_cooldown
  target_group_arns   = [aws_lb_target_group.target.arn]
  vpc_zone_identifier = [data.aws_subnet.private.id]
  launch_template {
    id      = aws_launch_template.template.id
    version = "$Latest"
  }
}


resource "aws_launch_template" "template" {
  name          = "${var.name}-launch-template"
  image_id      = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.micro"
  tags = {
    Name          = "${var.name}-launch-template"
    resource_type = "Launch Template"
  }
}
