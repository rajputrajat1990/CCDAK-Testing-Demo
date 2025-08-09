module "env" {
  source           = "./env"
  environment_name = "test-env"
    confluent_cloud_api_key    = var.confluent_cloud_api_key
  confluent_cloud_api_secret = var.confluent_cloud_api_secret
}

module "kafka_cluster" {
  source         = "./kafka_cluster"
  cluster_name   = "test-cluster"
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

module "sink_connector" {
  source = "./sink_connector"
}