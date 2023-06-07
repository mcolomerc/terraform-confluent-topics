variable "kafka_rest_endpoint" {
  type = string
}

variable "kafka_api_key" {
  type = string  
}

variable "kafka_api_secret" {
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


