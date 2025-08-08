output "environment_id" {
  description = "The ID of the created Confluent Cloud environment"
  value       = confluent_environment.this.id
}

output "schema_registry_url" {
  description = "The Schema Registry endpoint URL for the environment"
  value       = data.confluent_schema_registry_cluster.this.rest_endpoint
}
