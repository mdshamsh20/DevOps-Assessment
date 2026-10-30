variable "name" {
  description = "Name prefix for database resources."
  type        = string
}

variable "vpc_id" {
  description = "VPC in which to create the database."
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnets for the RDS subnet group."
  type        = list(string)
}

variable "ecs_security_group_id" {
  description = "Only this security group may connect to PostgreSQL."
  type        = string
}

variable "instance_class" {
  description = "RDS instance class."
  type        = string
}

variable "allocated_storage" {
  description = "Initial database storage in GiB."
  type        = number
}

variable "backup_retention_period" {
  description = "Automated backup retention in days."
  type        = number
}

variable "deletion_protection" {
  description = "Whether RDS deletion protection is enabled."
  type        = bool
}

variable "multi_az" {
  description = "Whether to deploy a standby database in another availability zone."
  type        = bool
}

variable "db_name" {
  description = "Initial database name."
  type        = string
}

variable "username" {
  description = "Master username."
  type        = string
}

variable "password" {
  description = "Master password."
  type        = string
  sensitive   = true
}
