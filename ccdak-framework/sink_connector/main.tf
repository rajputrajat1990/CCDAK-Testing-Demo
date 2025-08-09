terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.6.2"
    }
        confluent = {
      source  = "confluentinc/confluent"
      version = "~> 2.36.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}
resource "docker_network" "kafka_net" {
  name = "kafka_net"
}
resource "docker_image" "elasticsearch" {
  name = "docker.elastic.co/elasticsearch/elasticsearch:8.13.0"
}
resource "docker_container" "elasticsearch" {
  name  = "elasticsearch"
  image = docker_image.elasticsearch.image_id
  networks_advanced {
    name = docker_network.kafka_net.name
  }
  env = [
    "discovery.type=single-node",
    "xpack.security.enabled=true"
  ]
  ports {
    internal = 9200
    external = 9200
  }
}

resource "confluent_connector" "elasticsearch-db-sink" {
  environment {
    id = var.environment_id
  }
  kafka_cluster {
    id = var.kafka_cluster_id
  }

  config_sensitive = {
    "connection.password" = var.connection_password
  }


  config_nonsensitive = {
    "connector.class"          = "ElasticsearchSink"
    "name"                     = "elasticsearch-connector"
    "kafka.auth.mode"          = "KAFKA_API_KEY"
    "kafka.api.key" = var.kafka_api_key 
    "kafka.api.secret" = var.kafka_api_secret
    "topics"                   = var.topic_name
    "connection.url"           = var.connection_url
    "connection.username"      = "elastic"
    "input.data.format"        = "AVRO"
    "type.name"                = "<type-name>"
    "key.ignore"               = "true"
    "schema.ignore"            = "true"
    "tasks.max"                = "1"
  }

}