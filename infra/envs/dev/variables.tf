variable "aws_region" {
  description = "AWS region for dev resources."
  type        = string
}

variable "environment" {
  description = "Environment name."
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR block."
  type        = string
}

variable "availability_zones" {
  description = "Two availability zones for the VPC."
  type        = list(string)
}

variable "nat_gateway_count" {
  description = "NAT gateways used for private subnet egress."
  type        = number
}

variable "container_image" {
  description = "Placeholder application image."
  type        = string
}

variable "task_cpu" {
  description = "Fargate CPU units."
  type        = number
}

variable "task_memory" {
  description = "Fargate task memory in MiB."
  type        = number
}

variable "desired_count" {
  description = "Desired task count."
  type        = number
}

variable "db_instance_class" {
  description = "RDS instance class."
  type        = string
}

variable "db_allocated_storage" {
  description = "RDS allocated storage in GiB."
  type        = number
}

variable "db_backup_retention_period" {
  description = "RDS automated backup retention in days."
  type        = number
}

variable "db_deletion_protection" {
  description = "Enable RDS deletion protection."
  type        = bool
}

variable "db_multi_az" {
  description = "Deploy RDS with a standby in another availability zone."
  type        = bool
}

variable "db_name" {
  description = "Application database name."
  type        = string
}

variable "db_username" {
  description = "RDS master username."
  type        = string
}
