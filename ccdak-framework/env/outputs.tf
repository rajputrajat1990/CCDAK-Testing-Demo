output "environment_id" {
  description = "The ID of the created Confluent Cloud environment"
  value       = confluent_environment.this.id
}
