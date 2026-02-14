output "alb_dns_name" {
  description = "Public DNS name of the Application Load Balancer."
  value       = aws_lb.app.dns_name
}

output "asg_name" {
  description = "Name of the Auto Scaling Group for app instances."
  value       = aws_autoscaling_group.app.name
}

output "db_endpoint" {
  description = "RDS endpoint address."
  value       = aws_db_instance.main.address
}
