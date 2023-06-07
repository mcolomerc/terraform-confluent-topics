data "confluent_environment" "env" {
  id = var.environment
}

data "confluent_kafka_cluster" "cluster" {
  id = var.kafka_id
  environment {
    id = data.confluent_environment.env.id
  }
}

module "topic" {
  providers = {
    confluent = confluent.conluent_cloud
  }
  for_each            = { for topic in var.topics : topic.name => topic }
  source              = "./topic"
  environment         = var.environment
  kafka_id            = data.confluent_kafka_cluster.cluster.id
  kafka_rest_endpoint = data.confluent_kafka_cluster.cluster.rest_endpoint
  kafka_api_key       = var.kafka_api_key
  kafka_api_secret    = var.kafka_api_secret
  topic               = each.value
}
