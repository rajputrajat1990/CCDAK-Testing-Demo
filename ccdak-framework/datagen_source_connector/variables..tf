variable "connector_name" {
  description = "The name of the Datagen source connector."
  type        = string
}

variable "environment_id" {
  description = "The ID of the Confluent Cloud environment."
  type        = string
}

variable "kafka_cluster_id" {
  description = "The ID of the Kafka cluster."
  type        = string
}

variable "schema_registry_url" {
  description = "The URL of the Schema Registry."
  type        = string
}

variable "kafka_topic" {
  description = "The name of the Kafka topic to which the connector will produce data."
  type        = string
}

variable "quickstart_name" {
  description = "The name of the pre-defined dataset to generate (e.g., USERS, PAGEVIEWS, ORDERS)."
  type        = string
}

variable "kafka_rest_endpoint" {
  description = "The REST endpoint of the Kafka cluster."
  type        = string
}

variable "kafka_api_key" {
  description = "API key for the Kafka cluster."
  type        = string
}

variable "kafka_api_secret" {
  description = "API secret for the Kafka cluster."
  type        = string
}
