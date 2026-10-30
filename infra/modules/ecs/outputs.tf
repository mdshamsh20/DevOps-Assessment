output "ecs_security_group_id" {
  description = "Security group ID used by ECS tasks."
  value       = aws_security_group.ecs.id
}

output "load_balancer_dns_name" {
  description = "Public DNS name of the application load balancer."
  value       = aws_lb.this.dns_name
}
