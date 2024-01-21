# Confluent Cloud Credentials  
variable "confluent_cloud_api_key" {
  type = string
  description = "Confluent Cloud API KEY. export TF_VAR_confluent_cloud_api_key=\"API_KEY\""
}

variable "confluent_cloud_api_secret" {
  type = string
   description = "Confluent Cloud API KEY. export TF_VAR_confluent_cloud_api_secret=\"API_SECRET\""
}

# Confluent cloud environment id  
variable "environment" {
  type = string
   description = "Confluent Cloud Environment display name"
}

# Confluent cloud cluster id  
variable "cluster" {
  type = string
  description = "Confluent Cloud Cluster display name"
}

variable "kafka_api_key" {
  type = string  
}

variable "kafka_api_secret" {
  type = string
}

# Topic definition list 
variable "topics" {
  type = list(object({
    name = string
    partitions = number
    config =  optional(map(string))
  }))
  description = "List of Topics"
}


