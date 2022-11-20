output "topics" {
  value = {
    for k, t in module.topic : k => {
      id         = t.created_topic.id
      name       = t.created_topic.topic_name
      partitions = t.created_topic.partitions_count
      config     = t.created_topic.config
    }
  }
}