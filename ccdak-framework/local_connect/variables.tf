variable "kafka_bootstrap_endpoint" {
  description = "Bootstrap endpoint of the Kafka cluster."
  type        = string
}

variable "kafka_api_key" {
  description = "API key for the Kafka cluster."
  type        = string
  sensitive   = true
}

variable "kafka_api_secret" {
  description = "API secret for the Kafka cluster."
  type        = string
  sensitive   = true
}

variable "docker_network_name" {
  description = "The name of the Docker network to attach to."
  type        = string
}

variable "schema_registry_url" {
  description = "The URL of the Schema Registry."
  type        = string
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
