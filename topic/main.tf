


data "confluent_kafka_cluster" "kafka_cluster" {
  id = var.cluster
  environment {
    id = var.environment
  }
}
 

resource "confluent_kafka_topic" "topic" { 
  kafka_cluster {
    id = data.confluent_kafka_cluster.kafka_cluster.id
  }
  topic_name    = var.topic.name
  partitions_count   = var.topic.partitions
  rest_endpoint = data.confluent_kafka_cluster.kafka_cluster.rest_endpoint
  credentials {
    key    = var.admin_sa.id
    secret = var.admin_sa.secret
  }
  config = var.topic.config

  # It is recommended to set lifecycle { prevent_destroy = true } on production instances to prevent accidental topic deletion. 
  # This setting rejects plans that would destroy or recreate the topic, such as attempting to change uneditable attributes (for example, partitions_count).
  lifecycle {
    prevent_destroy = false
  } 
}

# RBAC  
data "confluent_service_account" "producer" {
  count        = var.rbac_enabled == true ? 1 : 0
  display_name = var.topic.producer
}

data "confluent_service_account" "consumer" {
  count        = var.rbac_enabled == true ? 1 : 0
  display_name = var.topic.consumer
}

## Role binding for the Kafka cluster 
resource "confluent_role_binding" "app-developer-read" {
  count       = var.rbac_enabled == true ? 1 : 0
  principal   = "User:${data.confluent_service_account.consumer[count.index].id}"
  role_name   = "DeveloperRead"
  crn_pattern = "${data.confluent_kafka_cluster.kafka_cluster.rbac_crn}/kafka=${data.confluent_kafka_cluster.kafka_cluster.id}/topic=${confluent_kafka_topic.topic.topic_name}"
  depends_on = [
    data.confluent_service_account.consumer,
    data.confluent_kafka_cluster.kafka_cluster,
    confluent_kafka_topic.topic
  ]
}

resource "confluent_role_binding" "app-developer-write" {
  count       = var.rbac_enabled == true ? 1 : 0
  principal   = "User:${data.confluent_service_account.producer[count.index].id}"
  role_name   = "DeveloperWrite"
  crn_pattern = "${data.confluent_kafka_cluster.kafka_cluster.rbac_crn}/kafka=${data.confluent_kafka_cluster.kafka_cluster.id}/topic=${confluent_kafka_topic.topic.topic_name}"
  depends_on = [
    data.confluent_service_account.producer,
    data.confluent_kafka_cluster.kafka_cluster,
    confluent_kafka_topic.topic
  ]
}
