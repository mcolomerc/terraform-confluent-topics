# Configure the Confluent Cloud Provider
terraform {
  required_version = ">= 0.15.0"
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "1.14.0"
    }
  }
  experiments = [module_variable_optional_attrs]
}
 
provider "confluent" {
  cloud_api_key    = var.confluent_cloud_api_key
  cloud_api_secret = var.confluent_cloud_api_secret
}
 