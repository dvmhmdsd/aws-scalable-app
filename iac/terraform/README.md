# Terraform Learning Journey

This folder will be built in small steps for a scalable AWS web app.

## Step 1 (current)
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

## Step 4 (current)
- Add Application Load Balancer in public subnets
- Add target group for app instances
- Add HTTP listener forwarding to target group
- Expose ALB DNS output

## Next Steps
1. Add launch template + ASG
2. Add RDS Multi-AZ
3. Add CloudWatch alarms + SNS alerts
