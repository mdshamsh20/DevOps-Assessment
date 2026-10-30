variable "name" {
  description = "Name prefix for network resources."
  type        = string
}

variable "vpc_cidr" {
  description = "VPC IPv4 CIDR block."
  type        = string
}

variable "availability_zones" {
  description = "Two availability zones used for public and private subnets."
  type        = list(string)

  validation {
    condition     = length(var.availability_zones) == 2
    error_message = "Exactly two availability zones are required."
  }
}

variable "nat_gateway_count" {
  description = "Number of NAT gateways. Use one per AZ for production resilience."
  type        = number

  validation {
    condition     = var.nat_gateway_count >= 1 && var.nat_gateway_count <= length(var.availability_zones)
    error_message = "NAT gateway count must be between one and the number of availability zones."
  }
}
