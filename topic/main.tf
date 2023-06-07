resource "confluent_kafka_topic" "topic" {
  topic_name       = var.topic.name
  partitions_count = var.topic.partitions
  rest_endpoint    = var.kafka_rest_endpoint

  credentials {
    kafka_api_key    = var.kafka_api_key
    kafka_api_secret = var.kafka_api_secret
  }
  config = var.topic.config

  # It is recommended to set lifecycle { prevent_destroy = true } on production instances to prevent accidental topic deletion. 
  # This setting rejects plans that would destroy or recreate the topic, such as attempting to change uneditable attributes (for example, partitions_count).
  lifecycle {
    prevent_destroy = false
  }
}
