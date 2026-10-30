variable "name" {
  description = "Name prefix for ECS and load balancer resources."
  type        = string
}

variable "aws_region" {
  description = "AWS region used for the container log configuration."
  type        = string
}

variable "vpc_id" {
  description = "VPC in which to create the service."
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnets for the application load balancer."
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "Private subnets for Fargate tasks."
  type        = list(string)
}

variable "container_image" {
  description = "Container image used by the placeholder service."
  type        = string
}

variable "task_cpu" {
  description = "Fargate task CPU units."
  type        = number
}

variable "task_memory" {
  description = "Fargate task memory in MiB."
  type        = number
}

variable "desired_count" {
  description = "Desired number of ECS tasks."
  type        = number
}
