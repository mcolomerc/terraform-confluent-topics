 

# Confluent cloud environment id  
variable "environment" {
  type = string
   description = "Confluent Cloud Environment Display Name"
}

# Confluent cloud cluster id  
variable "cluster" {
  type = string
  description = "Confluent Cloud Cluster Displa Name"
}

# RBAC enabled */
variable "rbac_enabled" {
  description = "Enable RBAC. If true producer/consumer will be used to configure Role Bindings for the Topic"
  type = bool
  default = false
}

# Topic definition list 
variable "topics" {
  type = list(object({
    name = string
    partitions = number
    config =  map(string)
    consumer = optional(string)
    producer = optional(string)
  }))
  description = "List of Topics. If RBAC enabled producer service account will be configured as DeveloperWrite and consumer will be configured as DeveloperRead."
}

 
# Service Account Credentials
variable "cluster_credentials" {
  type = object({ 
    api_key = string
    api_secret = string
  })
  description = "Confluent Cloud Cluster Credentials"
}

