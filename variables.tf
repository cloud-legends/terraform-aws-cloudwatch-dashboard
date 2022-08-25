variable "dashboard_name" {
  description = "Name of the dashboard"
  type        = string
  default     = "Overview"
}

variable "widget_height" {
  description = "Height in grid units of each widget"
  type        = number
  default     = 6
}

variable "widget_width" {
  description = "Width in grid units of each widget, in a 24 column grid"
  type        = number
  default     = 8
}

variable "default_region" {
  description = "Region used when no region is provided for a service. Defaults to current region."
  type        = string
  default     = null
}

variable "application_load_balancers" {
  description = "Application Load Balancers shown on dashboard"
  default     = []

  type = list(
    object({
      name   = string
      label  = optional(string)
      region = optional(string)

      target_groups = list(
        object({
          name  = string
          label = optional(string)
        })
      )
    })
  )
}

variable "cloudfront_distributions" {
  description = "CloudFront distributions shown on dashboard"
  default     = []

  type = list(
    object({
      name  = string
      label = optional(string)
    })
  )
}

variable "ecs_clusters" {
  description = "ECS clusters shown on dashboard"
  default     = []

  type = list(
    object({
      name   = string
      region = optional(string)
      label  = optional(string)

      services = list(
        object({
          name  = string
          label = optional(string)
        })
      )
    })
  )
}

variable "rds_instances" {
  description = "RDS databases shown on dashboard"
  default     = []

  type = list(
    object({
      name   = string
      region = optional(string)
      label  = optional(string)
    })
  )
}

variable "rds_aurora_clusters" {
  description = "RDS Aurora clusters shown on dashboard"
  default     = []

  type = list(
    object({
      name   = string
      region = optional(string)
      label  = optional(string)
    })
  )
}

variable "elasticache_redis_clusters" {
  description = "ElastiCache Redis clusters shown on dashboard"
  default     = []

  type = list(
    object({
      name   = string
      region = optional(string)
      label  = optional(string)
    })
  )
}

variable "elasticache_memcached_clusters" {
  description = "ElastiCache Memcached clusters shown on dashboard"
  default     = []

  type = list(
    object({
      name   = string
      region = optional(string)
      label  = optional(string)
    })
  )
}

variable "opensearch_clusters" {
  description = "OpenSearch clusters shown on dashboard"
  default     = []

  type = list(
    object({
      name   = string
      region = optional(string)
      label  = optional(string)
    })
  )
}
