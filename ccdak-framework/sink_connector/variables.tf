variable "kafka_cluster_id" {
  description = "The ID of the Kafka cluster where the topic will be created"
  type        = string
}
variable "environment_id" {
  description = "Environment ID in Confluent Cloud"
  type        = string
}
variable "topic_name" {
  description = "The name of the Kafka topic"
  type        = string
}
variable "connection_password" {
  description = "The name of the Kafka topic"
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

variable "kafka_rest_endpoint" {
  description = "The REST endpoint of the Kafka cluster"
  type        = string
}

variable "connection_url" {
  description = "The name of the Kafka topic"
  type        = string
}

variable "docker_network_name" {
  description = "The name of the Docker network to attach to."
  type        = string
}