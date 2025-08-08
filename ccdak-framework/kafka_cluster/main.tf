terraform {
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "~> 2.36.0"
    }
  }
}

provider "confluent" {
  cloud_api_key    = var.confluent_cloud_api_key
  cloud_api_secret = var.confluent_cloud_api_secret
}

resource "confluent_kafka_cluster" "basic_cluster" {
  display_name         = var.cluster_name
  availability         = "SINGLE_ZONE"
  cloud                = var.cloud_provider
  region               = var.cloud_region
  basic {}
  environment {
    id = var.environment_id
  }
}
