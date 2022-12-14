# Terraform Confluent Cloud Topics Module

Terraform module for Confluent Cloud Topics creation.

Provide a list of Topics and RBAC configuration.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15.0 |
| <a name="requirement_confluent"></a> [confluent](#requirement\_confluent) | ~>1.21.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_confluent"></a> [confluent](#provider\_confluent) | 1.21.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_topic"></a> [topic](#module\_topic) | ./topic | n/a |

## Resources

| Name | Type |
|------|------|
| [confluent_api_key.saccount_kafka_api_key](https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/api_key) | resource |
| [confluent_role_binding.saccount_role](https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/role_binding) | resource |
| [confluent_environment.env](https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/data-sources/environment) | data source |
| [confluent_kafka_cluster.cluster](https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/data-sources/kafka_cluster) | data source |
| [confluent_service_account.saccount](https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/data-sources/service_account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster"></a> [cluster](#input\_cluster) | Confluent Cloud Cluster ID | `string` | n/a | yes |
| <a name="input_confluent_cloud_api_key"></a> [confluent\_cloud\_api\_key](#input\_confluent\_cloud\_api\_key) | Confluent Cloud API KEY. export TF\_VAR\_confluent\_cloud\_api\_key="API\_KEY" | `string` | n/a | yes |
| <a name="input_confluent_cloud_api_secret"></a> [confluent\_cloud\_api\_secret](#input\_confluent\_cloud\_api\_secret) | Confluent Cloud API KEY. export TF\_VAR\_confluent\_cloud\_api\_secret="API\_SECRET" | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Confluent Cloud Environment ID | `string` | n/a | yes |
| <a name="input_rbac_enabled"></a> [rbac\_enabled](#input\_rbac\_enabled) | Enable RBAC. If true producer/consumer will be used to configure Role Bindings for the Topic | `bool` | `false` | no |
| <a name="input_serv_account"></a> [serv\_account](#input\_serv\_account) | Service Account and Role for cluster management. | <pre>object({<br>      name = string<br>      role = string<br>    })</pre> | n/a | yes |
| <a name="input_topics"></a> [topics](#input\_topics) | List of Topics. If RBAC enabled producer service account will be configured as DeveloperWrite and consumer will be configured as DeveloperRead. | <pre>list(object({<br>    name = string<br>    partitions = number<br>    config =  map(string)<br>    consumer = optional(string)<br>    producer = optional(string)<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_topics"></a> [topics](#output\_topics) | n/a |
<!-- END_TF_DOCS -->

---

## Topic Deletion

This module uses `lifecycle { prevent_destroy = false }`, to prevent accidental topic deletion use `prevent_destroy = true`

This setting rejects plans that would destroy or recreate the topic, such as attempting to change uneditable attributes (for example, partitions_count).
  
```hcl
lifecycle {
    prevent_destroy = false
  }
```

When `prevent_destroy = true`: 

`Resource module.topic["topic_name"].confluent_kafka_topic.topic has lifecycle.prevent_destroy set`, but the plan calls for this resource to be destroyed. To avoid this error and continue with the plan, either disable
│ `lifecycle.prevent_destroy` or reduce the scope of the plan using the `-target` flag.