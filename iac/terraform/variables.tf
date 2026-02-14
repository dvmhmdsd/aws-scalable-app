variable "project_name" {
  description = "Project identifier used in names and tags."
  type        = string
  default     = "scalable-web-app"
}

variable "environment" {
  description = "Deployment environment name."
  type        = string
  default     = "dev"
}

variable "aws_region" {
  description = "AWS region for all resources."
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "Two CIDR blocks for public subnets (one per AZ)."
  type        = list(string)
  default     = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "private_app_subnet_cidrs" {
  description = "Two CIDR blocks for private app subnets (one per AZ)."
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.11.0/24"]
}

variable "private_db_subnet_cidrs" {
  description = "Two CIDR blocks for private database subnets (one per AZ)."
  type        = list(string)
  default     = ["10.0.20.0/24", "10.0.21.0/24"]
}

variable "instance_type" {
  description = "EC2 instance type for app instances."
  type        = string
  default     = "t3.micro"
}

variable "asg_desired_capacity" {
  description = "Desired number of app instances in ASG."
  type        = number
  default     = 2
}

variable "asg_min_size" {
  description = "Minimum number of app instances in ASG."
  type        = number
  default     = 2
}

variable "asg_max_size" {
  description = "Maximum number of app instances in ASG."
  type        = number
  default     = 4
}

variable "db_engine" {
  description = "Database engine."
  type        = string
  default     = "postgres"
}

variable "db_engine_version" {
  description = "Database engine version."
  type        = string
  default     = "16.4"
}

variable "db_instance_class" {
  description = "RDS instance class."
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "Storage size (GiB) for RDS."
  type        = number
  default     = 20
}

variable "db_name" {
  description = "Initial database name."
  type        = string
  default     = "appdb"
}

variable "db_username" {
  description = "Master username for RDS."
  type        = string
  default     = "appadmin"
}

variable "db_password" {
  description = "Master password for RDS."
  type        = string
  sensitive   = true
}

variable "db_port" {
  description = "Database port."
  type        = number
  default     = 5432
}

variable "db_multi_az" {
  description = "Enable Multi-AZ deployment for RDS."
  type        = bool
  default     = true
}

variable "alert_email" {
  description = "Email address for alarm notifications. Leave empty to skip subscription."
  type        = string
  default     = ""
}
