variable "kafka_cluster_bootstrap_endpoint" {
  description = "confluent cloud kafka bootstrap servers"
  type        = string
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