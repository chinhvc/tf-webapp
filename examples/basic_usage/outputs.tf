output "web_app_instance_id" {
  description = "The ID of the web app EC2 instance."
  value       = module.web_app.web_app_instance_id
}

output "web_app_public_ip" {
  description = "The public IP address of the web app EC2 instance."
  value       = module.web_app.web_app_public_ip
}

output "db_instance_endpoint" {
  description = "The endpoint of the RDS instance."
  value       = module.web_app.db_instance_endpoint
}
