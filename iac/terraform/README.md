# Terraform Learning Journey

This folder will be built in small steps for a scalable AWS web app.

## Step 1
- Bootstrap Terraform project structure
- Configure AWS provider and Terraform version
- Define base variables (`project_name`, `environment`, `aws_region`)
- Create shared tags in `locals`

## Step 2
- Build VPC with DNS support
- Create public, private app, and private DB subnets across 2 AZs
- Add Internet Gateway and NAT Gateway
- Configure route tables and subnet associations

## Step 3
- Add security groups for ALB, app tier, and DB tier
- Enforce least-privilege flow:
  - Internet -> ALB (80)
  - ALB -> app instances (80)
  - App instances -> DB (5432)

## Step 4
- Add Application Load Balancer in public subnets
- Add target group for app instances
- Add HTTP listener forwarding to target group
- Expose ALB DNS output

## Step 5
- Add launch template using latest Amazon Linux 2023 AMI from SSM
- Add EC2 IAM role and instance profile for Systems Manager access
- Add Auto Scaling Group in private app subnets and attach to ALB target group
- Add target-tracking scaling policy (CPU-based)

## Step 6 (current)
- Add DB subnet group in private DB subnets
- Add Amazon RDS instance with Multi-AZ support
- Attach DB security group and expose DB endpoint output

## Next Steps
1. Add CloudWatch alarms + SNS alerts
