terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.6.2"
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
  image = docker_image.elasticsearch.latest
  networks_advanced {
    name = docker_network.kafka_net.name
  }
  env = [
    "discovery.type=single-node",
    "xpack.security.enabled=false"
  ]
  ports {
    internal = 9200
    external = 9200
  }
}

# https://github.com/confluentinc/terraform-provider-confluent/tree/master/examples/configurations/connectors/manage-offsets-source-sink-connector
resource "confluent_connector" "sink" {
  environment {
    id = data.confluent_environment.staging.id
  }

  kafka_cluster {
    id = data.confluent_kafka_cluster.basic_cluster.id
  }
  config_sensitive = {
    "connection.password" = "***REDACTED***"

  }
  config_nonsensitive = {
    "connector.class"          = "MySqlSink"
    "name"                     = "MySQLSinkConnector_0"
    "topics"                   = confluent_kafka_topic.orders.topic_name
    "input.data.format"        = "AVRO"
    "kafka.auth.mode"          = "SERVICE_ACCOUNT"
    "kafka.service.account.id" = confluent_service_account.app-connector.id
    "db.name"                  = "test_database"
    "connection.user"          = "confluent_user"
    "connection.host"          = "dev-testing-temp.abcdefghijk.us-west-7.rds.amazonaws.com"
    "connection.port"          = "3306"
    "insert.mode"              = "INSERT"
    "auto.create"              = "true"
    "auto.evolve"              = "true"
    "tasks.max"                = "1"
  }

  offsets {
    partition = {
      "kafka_partition" = "0"
      "kafka_topic"     = confluent_kafka_topic.orders.topic_name
    }
    offset = {
      "kafka_offset" = "100"
    }
  }
  offsets {
    partition = {
      "kafka_partition" = "1"
      "kafka_topic"     = confluent_kafka_topic.orders.topic_name
    }
    offset = {
      "kafka_offset" = "200"
    }
  }
  offsets {
    partition = {
      "kafka_partition" = "2"
      "kafka_topic"     = confluent_kafka_topic.orders.topic_name
    }
    offset = {
      "kafka_offset" = "300"
    }
  }
  depends_on = [
    confluent_kafka_acl.app-connector-describe-on-cluster,
    confluent_kafka_acl.app-connector-read-on-target-topic,
    confluent_kafka_acl.app-connector-create-on-dlq-lcc-topics,
    confluent_kafka_acl.app-connector-write-on-dlq-lcc-topics,
    confluent_kafka_acl.app-connector-create-on-success-lcc-topics,
    confluent_kafka_acl.app-connector-write-on-success-lcc-topics,
    confluent_kafka_acl.app-connector-create-on-error-lcc-topics,
    confluent_kafka_acl.app-connector-write-on-error-lcc-topics,
    confluent_kafka_acl.app-connector-read-on-connect-lcc-group,
  ]
}
