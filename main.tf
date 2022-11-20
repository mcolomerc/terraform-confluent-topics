data "confluent_environment" "env" {
  id = var.environment
}

data "confluent_kafka_cluster" "cluster" {
  id = var.cluster
  environment {
    id = data.confluent_environment.env.id
  }
}

data "confluent_service_account" "saccount" {
  display_name = var.serv_account.name 
}

resource "confluent_role_binding" "saccount_role" {
  count       = var.serv_account.role != null ? 1 : 0
  principal   = "User:${data.confluent_service_account.saccount.id}"
  role_name   = var.serv_account.role
  crn_pattern = data.confluent_kafka_cluster.cluster.rbac_crn
  depends_on = [
    data.confluent_service_account.saccount
  ]
}

resource "confluent_api_key" "saccount_kafka_api_key" {
  display_name = "${var.serv_account.name}_kafka_api_key"
  description  = "Kafka API Key that is owned by ${var.serv_account.name} service account"
  owner {
    id          = data.confluent_service_account.saccount.id
    api_version = data.confluent_service_account.saccount.api_version
    kind        = data.confluent_service_account.saccount.kind
  }

  managed_resource {
    id          = data.confluent_kafka_cluster.cluster.id
    api_version = data.confluent_kafka_cluster.cluster.api_version
    kind        = data.confluent_kafka_cluster.cluster.kind

    environment {
      id = data.confluent_environment.env.id
    }
  }
  depends_on = [
    data.confluent_service_account.saccount
  ]
}

module "topic" {
  for_each        = { for topic in var.topics : topic.name => topic }
  source          = "./topic"
  environment     = var.environment
  cluster         = data.confluent_kafka_cluster.cluster.id
  topic           = each.value
  admin_sa        = confluent_api_key.saccount_kafka_api_key
  rbac_enabled    = var.rbac_enabled 
  depends_on = [
    confluent_api_key.saccount_kafka_api_key
  ]
}
