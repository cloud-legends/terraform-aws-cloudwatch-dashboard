# CloudWatch dashboard

This Terraform module creates an AWS CloudWatch dashboard that displays an
opinionated set of widgets. The module accepts services via the variables and
automatically adds some widgets for each service.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_dashboard.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_dashboard) | resource |
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_load_balancers"></a> [application\_load\_balancers](#input\_application\_load\_balancers) | Application Load Balancers shown on dashboard | <pre>list(<br>    object({<br>      name   = string<br>      label  = optional(string)<br>      region = optional(string)<br><br>      target_groups = list(<br>        object({<br>          name  = string<br>          label = optional(string)<br>        })<br>      )<br>    })<br>  )</pre> | `[]` | no |
| <a name="input_cloudfront_distributions"></a> [cloudfront\_distributions](#input\_cloudfront\_distributions) | CloudFront distributions shown on dashboard | <pre>list(<br>    object({<br>      name  = string<br>      label = optional(string)<br>    })<br>  )</pre> | `[]` | no |
| <a name="input_dashboard_name"></a> [dashboard\_name](#input\_dashboard\_name) | Name of the dashboard | `string` | `"Overview"` | no |
| <a name="input_default_region"></a> [default\_region](#input\_default\_region) | Region used when no region is provided for a service. Defaults to current region. | `string` | `null` | no |
| <a name="input_ecs_clusters"></a> [ecs\_clusters](#input\_ecs\_clusters) | ECS clusters shown on dashboard | <pre>list(<br>    object({<br>      name   = string<br>      region = optional(string)<br>      label  = optional(string)<br><br>      services = list(<br>        object({<br>          name  = string<br>          label = optional(string)<br>        })<br>      )<br>    })<br>  )</pre> | `[]` | no |
| <a name="input_elasticache_memcached_clusters"></a> [elasticache\_memcached\_clusters](#input\_elasticache\_memcached\_clusters) | ElastiCache Memcached clusters shown on dashboard | <pre>list(<br>    object({<br>      name   = string<br>      region = optional(string)<br>      label  = optional(string)<br>    })<br>  )</pre> | `[]` | no |
| <a name="input_elasticache_redis_clusters"></a> [elasticache\_redis\_clusters](#input\_elasticache\_redis\_clusters) | ElastiCache Redis clusters shown on dashboard | <pre>list(<br>    object({<br>      name   = string<br>      region = optional(string)<br>      label  = optional(string)<br>    })<br>  )</pre> | `[]` | no |
| <a name="input_opensearch_clusters"></a> [opensearch\_clusters](#input\_opensearch\_clusters) | OpenSearch clusters shown on dashboard | <pre>list(<br>    object({<br>      name   = string<br>      region = optional(string)<br>      label  = optional(string)<br>    })<br>  )</pre> | `[]` | no |
| <a name="input_rds_aurora_clusters"></a> [rds\_aurora\_clusters](#input\_rds\_aurora\_clusters) | RDS Aurora clusters shown on dashboard | <pre>list(<br>    object({<br>      name   = string<br>      region = optional(string)<br>      label  = optional(string)<br>    })<br>  )</pre> | `[]` | no |
| <a name="input_rds_instances"></a> [rds\_instances](#input\_rds\_instances) | RDS databases shown on dashboard | <pre>list(<br>    object({<br>      name   = string<br>      region = optional(string)<br>      label  = optional(string)<br>    })<br>  )</pre> | `[]` | no |
| <a name="input_widget_height"></a> [widget\_height](#input\_widget\_height) | Height in grid units of each widget | `number` | `6` | no |
| <a name="input_widget_width"></a> [widget\_width](#input\_widget\_width) | Width in grid units of each widget, in a 24 column grid | `number` | `8` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->