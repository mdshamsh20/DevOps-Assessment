output "load_balancer_url" {
  description = "URL of the public application load balancer."
  value       = "http://${module.ecs.load_balancer_dns_name}"
}

output "database_endpoint" {
  description = "Private RDS endpoint; reachable only from the VPC."
  value       = "${module.rds.address}:${module.rds.port}"
}
