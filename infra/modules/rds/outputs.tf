output "address" {
  description = "Private RDS endpoint address."
  value       = aws_db_instance.this.address
}

output "port" {
  description = "RDS PostgreSQL port."
  value       = aws_db_instance.this.port
}
