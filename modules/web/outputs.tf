output "web_app_instance_id" {
  description = "The ID of the web app EC2 instance."
  value       = aws_instance.web_app.id
}

output "web_app_public_ip" {
  description = "The public IP address of the web app EC2 instance."
  value       = aws_instance.web_app.public_ip
}

output "db_instance_id" {
  description = "The ID of the RDS instance."
  value       = aws_db_instance.private_db.id
}

output "db_instance_endpoint" {
  description = "The endpoint of the RDS instance."
  value       = aws_db_instance.private_db.endpoint
}
