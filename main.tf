data "confluent_environment" "env" {
  id = var.environment
}

data "confluent_kafka_cluster" "cluster" {
  id = var.cluster
  environment {
    id = data.confluent_environment.env.id
  }
} 

module "topic" {
  for_each        = { for topic in var.topics : topic.name => topic }
  source          = "./topic"
  environment     = data.confluent_environment.env.id
  cluster         = data.confluent_kafka_cluster.cluster.id
  topic           = each.value
  admin_sa        = {
    id = var.cluster_credentials.api_key
    secret = var.cluster_credentials.api_secret
  }
  rbac_enabled    = var.rbac_enabled  
}
