terraform {
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "~> 2.36.0"
    }
  }
}

resource "confluent_kafka_topic" "this" {
  kafka_cluster {
    id = var.kafka_cluster_id
  }
  topic_name       = var.topic_name
  partitions_count = 1
  rest_endpoint = var.kafka_rest_endpoint
  config = {
    "cleanup.policy" = "delete"
  }

  lifecycle {
    prevent_destroy = false
  }
    credentials { 
      key = var.kafka_api_key 
      secret = var.kafka_api_secret
      }
}
