# Terraform Confluent Cloud Topics Module

Terraform module for Confluent Cloud Topics creation.

Provide a list of Topics and RBAC configuration.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_confluent"></a> [confluent](#requirement\_confluent) | ~>1.51.0 |

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
| [confluent_environment.env](https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/data-sources/environment) | data source |
| [confluent_kafka_cluster.cluster](https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/data-sources/kafka_cluster) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster"></a> [cluster](#input\_cluster) | Confluent Cloud Cluster ID | `string` | n/a | yes |
| <a name="input_cluster_credentials"></a> [cluster\_credentials](#input\_cluster\_credentials) | Confluent Cloud Cluster Credentials | <pre>object({ <br>    api_key = string<br>    api_secret = string<br>  })</pre> | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Confluent Cloud Environment ID | `string` | n/a | yes |
| <a name="input_rbac_enabled"></a> [rbac\_enabled](#input\_rbac\_enabled) | Enable RBAC. If true producer/consumer will be used to configure Role Bindings for the Topic | `bool` | `false` | no |
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