output "asg_id" {
  description = "ASG ID"
  value       = aws_autoscaling_group.main.id
}

output "alb_id" {
  description = "Application Load Balancer ID"
  value       = aws_alb.lb.id
}
