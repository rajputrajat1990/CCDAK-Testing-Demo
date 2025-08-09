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