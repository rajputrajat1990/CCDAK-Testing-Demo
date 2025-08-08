output "kafka_cluster_id" {
  description = "The ID of the Kafka cluster"
  value       = confluent_kafka_cluster.basic_cluster.id
}
output "kafka_cluster_bootstrap_endpoint" {
  description = "Bootstrap endpoint of the Kafka cluster"
  value       = confluent_kafka_cluster.basic_cluster.bootstrap_endpoint
}

output "rest_endpoint" {
  value = confluent_kafka_cluster.basic_cluster.rest_endpoint
}
