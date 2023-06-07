variable "environment" {
  type = string
   description = "Confluent Cloud Environment ID"
}

# Confluent cloud cluster id  
variable "cluster" {
  type = string
  description = "Confluent Cloud Cluster ID"
}

variable "kafka_api_key" {
  type = string
  description = "Cluster Admin Manager API Key"  
}

variable "kafka_api_secret" {
  type = string
  description = "Cluster Admin Manager API Secret"
}

variable "kafka_rest_endpoint" {
  type = string
}

# Topic definition list 
variable "topic" {
  type = object({
    name     = string
    partitions = number
    config   =  map(string)
  })
}


