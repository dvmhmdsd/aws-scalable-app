output "alb_dns_name" {
  description = "Public DNS name of the Application Load Balancer."
  value       = aws_lb.app.dns_name
}

output "asg_name" {
  description = "Name of the Auto Scaling Group for app instances."
  value       = aws_autoscaling_group.app.name
}

output "db_endpoint" {
  description = "RDS endpoint."
  value       = aws_db_instance.main.endpoint
}

output "alerts_topic_arn" {
  description = "SNS topic ARN used by CloudWatch alarms."
  value       = aws_sns_topic.alerts.arn
}

output "rds_read_replica_endpoints" {
  description = "List of RDS read replica endpoints."
  value       = aws_db_instance.read_replica[*].endpoint
}
