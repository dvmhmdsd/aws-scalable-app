# Terraform Learning Journey

This folder will be built in small steps for a scalable AWS web app.

## Step 1 (current)
- Bootstrap Terraform project structure
- Configure AWS provider and Terraform version
- Define base variables (`project_name`, `environment`, `aws_region`)
- Create shared tags in `locals`

## Step 2 (current)
- Build VPC with DNS support
- Create public, private app, and private DB subnets across 2 AZs
- Add Internet Gateway and NAT Gateway
- Configure route tables and subnet associations

## Next Steps
1. Add security groups
2. Add ALB + target group
3. Add launch template + ASG
4. Add RDS Multi-AZ
5. Add CloudWatch alarms + SNS alerts
