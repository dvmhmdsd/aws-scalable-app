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

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "Must be a valid IPv4 CIDR block."
  }
}

variable "public_subnet_cidrs" {
  description = "Two CIDR blocks for public subnets (one per AZ)."
  type        = list(string)
  default     = ["10.0.0.0/24", "10.0.1.0/24"]

  validation {
    condition     = alltrue([for cidr in var.public_subnet_cidrs : can(cidrhost(cidr, 0))])
    error_message = "All subnet CIDRs must be valid IPv4 CIDR blocks."
  }

  validation {
    condition     = length(var.public_subnet_cidrs) == 2
    error_message = "Must provide exactly 2 CIDR blocks for public subnets."
  }
}

variable "private_app_subnet_cidrs" {
  description = "Two CIDR blocks for private app subnets (one per AZ)."
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.11.0/24"]

  validation {
    condition     = alltrue([for cidr in var.private_app_subnet_cidrs : can(cidrhost(cidr, 0))])
    error_message = "All subnet CIDRs must be valid IPv4 CIDR blocks."
  }

  validation {
    condition     = length(var.private_app_subnet_cidrs) == 2
    error_message = "Must provide exactly 2 CIDR blocks for private app subnets."
  }
}

variable "private_db_subnet_cidrs" {
  description = "Two CIDR blocks for private database subnets (one per AZ)."
  type        = list(string)
  default     = ["10.0.20.0/24", "10.0.21.0/24"]

  validation {
    condition     = alltrue([for cidr in var.private_db_subnet_cidrs : can(cidrhost(cidr, 0))])
    error_message = "All subnet CIDRs must be valid IPv4 CIDR blocks."
  }

  validation {
    condition     = length(var.private_db_subnet_cidrs) == 2
    error_message = "Must provide exactly 2 CIDR blocks for private database subnets."
  }
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

  validation {
    condition     = var.asg_desired_capacity >= var.asg_min_size && var.asg_desired_capacity <= var.asg_max_size
    error_message = "Desired capacity must be between min_size and max_size."
  }
}

variable "asg_min_size" {
  description = "Minimum number of app instances in ASG."
  type        = number
  default     = 2

  validation {
    condition     = var.asg_min_size >= 1
    error_message = "ASG minimum size must be at least 1."
  }
}

variable "asg_max_size" {
  description = "Maximum number of app instances in ASG."
  type        = number
  default     = 4

  validation {
    condition     = var.asg_max_size >= var.asg_min_size
    error_message = "ASG maximum size must be greater than or equal to minimum size."
  }
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

variable "db_backup_retention_period" {
  description = "Number of days to retain automated backups (0-35). Use 1-3 for dev, 7-30 for production."
  type        = number
  default     = 3

  validation {
    condition     = var.db_backup_retention_period >= 0 && var.db_backup_retention_period <= 35
    error_message = "Backup retention period must be between 0 and 35 days."
  }
}

variable "alert_email" {
  description = "Email address for alarm notifications. Leave empty to skip subscription."
  type        = string
  default     = ""
}
