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

