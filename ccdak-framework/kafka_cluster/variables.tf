variable "cluster_name" {
  description = "Name of the Kafka cluster"
  type        = string
}
variable "cloud_provider" {
  description = "Cloud provider for the Kafka cluster (e.g., aws)"
  type        = string
}
variable "cloud_region" {
  description = "Region for the Kafka cluster (e.g., us-east-2)"
  type        = string
}
variable "environment_id" {
  description = "Environment ID in Confluent Cloud"
  type        = string
}
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
