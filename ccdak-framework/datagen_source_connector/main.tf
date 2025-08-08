terraform {
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "~> 2.36.0"
    }
  }
}

resource "confluent_connector" "source" {
  environment {
    id = var.environment_id
  }

  kafka_cluster {
    id = var.kafka_cluster_id
  }


  config_nonsensitive = {
    "connector.class"          = "DatagenSource"
    "name" = "DatagenSourceConnector_0"
    "kafka.auth.mode" = "KAFKA_API_KEY"
    "kafka.api.key" = var.kafka_api_key 
    "kafka.api.secret" = var.kafka_api_secret
    "kafka.topic"              = var.kafka_topic
    "quickstart"               = var.quickstart_name
    "tasks.max"                = "1"
    "output.data.format"       = "AVRO"
    "value.converter.schema.registry.url" = var.schema_registry_url
    "value.converter"          = "io.confluent.connect.avro.AvroConverter"
  }
}
