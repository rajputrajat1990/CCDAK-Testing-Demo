# local_connect/main.tf

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0" # It's good practice to pin the provider version
    }
  }
}

resource "docker_image" "connect" {
  name = "confluentinc/cp-server-connect:7.6.1"
  keep_locally = true
}

resource "docker_container" "connect" {
  name  = "kafka-connect-local"
  image = docker_image.connect.image_id

  networks_advanced {
    name = var.docker_network_name
  }

  ports {
    internal = 8083
    external = 8083
  }

  # These are the crucial settings to connect our local worker to Confluent Cloud
  env = [
    "CONNECT_BOOTSTRAP_SERVERS=${var.kafka_bootstrap_endpoint}",
    "CONNECT_REST_ADVERTISED_HOST_NAME=connect",
    "CONNECT_REST_PORT=8083",
    "CONNECT_GROUP_ID=local-connect-group",
    "CONNECT_CONFIG_STORAGE_TOPIC=local-connect-configs",
    "CONNECT_OFFSET_STORAGE_TOPIC=local-connect-offsets",
    "CONNECT_STATUS_STORAGE_TOPIC=local-connect-status",
    "CONNECT_KEY_CONVERTER=org.apache.kafka.connect.storage.StringConverter",
    "CONNECT_VALUE_CONVERTER=io.confluent.connect.avro.AvroConverter",
    "CONNECT_VALUE_CONVERTER_SCHEMA_REGISTRY_URL=${var.schema_registry_url}", # We'll need to adjust how this is passed in
    
    # Security configuration for Confluent Cloud
    "CONNECT_SECURITY_PROTOCOL=SASL_SSL",
    "CONNECT_SASL_MECHANISM=PLAIN",
    "CONNECT_SASL_JAAS_CONFIG=org.apache.kafka.common.security.plain.PlainLoginModule required username=\"${var.kafka_api_key}\" password=\"${var.kafka_api_secret}\";",

"CONNECT_VALUE_CONVERTER_BASIC_AUTH_USER_INFO=${var.schema_registry_api_key}:${var.schema_registry_api_secret}",
    "CONNECT_VALUE_CONVERTER_BASIC_AUTH_CREDENTIALS_SOURCE=USER_INFO",

    # Tells Connect where to find plugins
    "CONNECT_PLUGIN_PATH=/usr/share/java,/usr/share/confluent-hub-components"
  ]
}
