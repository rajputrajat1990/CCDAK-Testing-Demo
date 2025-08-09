module "env" {
  source           = "./env"
  environment_name = "test-env"
    confluent_cloud_api_key    = var.confluent_cloud_api_key
  confluent_cloud_api_secret = var.confluent_cloud_api_secret
}

module "kafka_cluster" {
  source         = "./kafka_cluster"
  cluster_name   = var.cluster_name
  cloud_provider = "AWS"
  cloud_region   = "us-east-2"
  environment_id = module.env.environment_id
  confluent_cloud_api_key    = var.confluent_cloud_api_key
  confluent_cloud_api_secret = var.confluent_cloud_api_secret
}

module "topic" {
  source           = "./topic"
  kafka_cluster_id = module.kafka_cluster.kafka_cluster_id
  topic_name       = "orders"
  kafka_rest_endpoint  = module.kafka_cluster.rest_endpoint
  kafka_api_key    = var.kafka_api_key
  kafka_api_secret = var.kafka_api_secret
}

module "datagen_source_connector" {
  source              = "./datagen_source_connector"
  connector_name      = "datagen-source-users"
  environment_id      = module.env.environment_id
  kafka_cluster_id    = module.kafka_cluster.kafka_cluster_id
  schema_registry_url = module.env.schema_registry_url
  kafka_topic         = module.topic.topic_name
  quickstart_name     = "ORDERS"
  
  # Add these new inputs
  kafka_rest_endpoint = module.kafka_cluster.rest_endpoint
  kafka_api_key       = var.kafka_api_key
  kafka_api_secret    = var.kafka_api_secret
}

resource "docker_network" "kafka_net" {
  name = "kafka_net"
}

module "sink_connector" {
  source = "./sink_connector"
  kafka_cluster_id = module.kafka_cluster.kafka_cluster_id
  topic_name       = module.topic.topic_name
  environment_id      = module.env.environment_id
  kafka_rest_endpoint  = module.kafka_cluster.rest_endpoint
  kafka_api_key    = var.kafka_api_key
  kafka_api_secret = var.kafka_api_secret
  connection_url = "http://localhost:9200"
  connection_password = "changeme"
  docker_network_name = docker_network.kafka_net.name
}

module "local_connect" {
  source = "./local_connect"

  kafka_bootstrap_endpoint = module.kafka_cluster.kafka_cluster_bootstrap_endpoint
  kafka_api_key            = var.kafka_api_key # Assumes you have this in your root variables.tf
  kafka_api_secret         = var.kafka_api_secret # Assumes you have this in your root variables.tf

  # We need to get schema registry credentials. Let's assume you create a service account for it.
  # For now, we can placeholder this, but a full solution would create SR credentials.
  schema_registry_url      = module.env.schema_registry_url 
  schema_registry_api_key    = var.schema_registry_api_key # This would come from a new resource/variable
  schema_registry_api_secret = var.schema_registry_api_key # This would come from a new resource/variable

  docker_network_name = docker_network.kafka_net.name

  depends_on = [
    module.kafka_cluster
  ]
}


