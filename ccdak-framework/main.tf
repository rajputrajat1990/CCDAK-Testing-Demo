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
