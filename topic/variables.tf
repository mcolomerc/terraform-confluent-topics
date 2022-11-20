# Confluent cloud environment id  
variable "environment" {
  type = string
}

# Confluent cloud cluster id  
variable "cluster" {
  type = string
}

# RBAC enabled */
variable "rbac_enabled" {
  type = bool
}

# Topic definition list 
variable "topic" {
  type = object({
    name     = string
    partitions = number
    config   =  map(string)
    consumer = optional(string)
    producer = optional(string)
  })
}

# Confluent Cloud Service Account  
variable "admin_sa" {
  type = object({
    id     = string
    secret = string
  })
}


