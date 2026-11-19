# modules/orders-db/outputs.tf
output "endpoint" {
  description = "Connection endpoint (host:port)"
  value       = aws_db_instance.main.endpoint
}

output "master_user_secret_arn" {
  description = "Secrets Manager secret with the master password"
  value       = aws_db_instance.main.master_user_secret[0].secret_arn
}
