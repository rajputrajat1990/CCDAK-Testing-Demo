variable "confluent_cloud_api_key" {
  description = "Confluent Cloud API Key"
  type        = string
  sensitive   = true
}

variable "confluent_cloud_api_secret" {
  description = "Confluent Cloud API Secret"
  type        = string
  sensitive   = true
}

variable "kafka_api_key" {
  description = "Existing Confluent Kafka API key ID"
  type        = string
  sensitive   = true
}

variable "kafka_api_secret" {
  description = "Existing Confluent Kafka API key secret"
  type        = string
  sensitive   = true
}

variable "schema_registry_api_key" {
  description = "API key for the Schema Registry."
  type        = string
  sensitive   = true
}

variable "schema_registry_api_secret" {
  description = "API secret for the Schema Registry."
  type        = string
  sensitive   = true
}


