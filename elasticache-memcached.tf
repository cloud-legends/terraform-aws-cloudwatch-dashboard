locals {
  elasticache_memcached_hit_metrics = [
    "CasHits",
    "DecrHits",
    "DeleteHits",
    "GetHits",
    "IncrHits",
    "TouchHits",
  ]

  elasticache_memcached_miss_metrics = [
    "CasMisses",
    "DecrMisses",
    "DeleteMisses",
    "GetMisses",
    "IncrMisses",
    "TouchMisses",
  ]

  elasticache_memcached_hits_expr = join(
    " + ",
    [for metric in local.elasticache_memcached_hit_metrics : lower(metric)]
  )

  elasticache_memcached_misses_expr = join(
    " + ",
    [for metric in local.elasticache_memcached_miss_metrics : lower(metric)]
  )

  elasticache_memcached_total_expr = <<EOF
    ${local.elasticache_memcached_hits_expr} +
    ${local.elasticache_memcached_misses_expr}
  EOF

  elasticache_memcached_hit_rate_expr = <<-EOF
    (${local.elasticache_memcached_hits_expr}) * 100 /
    (${local.elasticache_memcached_total_expr})
  EOF

  elasticache_memcached_widgets = concat([], [
    for cluster in var.elasticache_memcached_clusters :
    [
      {
        type = "metric"

        properties = {
          title  = "[ElastiCache] Connections & CPU (cluster: ${coalesce(cluster.label, cluster.name)})"
          view   = "timeSeries"
          region = coalesce(cluster.region, var.default_region)

          yAxis = {
            left = {
              min = 0
            }

            right = {
              min = 0
              max = 100
            }
          }

          metrics = [
            [
              "AWS/ElastiCache",
              "CurrConnections",
              "CacheClusterId",
              cluster.name,
              { yAxis = "left" }
            ],
            [
              "AWS/ElastiCache",
              "CPUUtilization",
              "CacheClusterId",
              cluster.name,
              { yAxis = "right" }
            ]
          ]
        }
      },
      {
        type = "metric"

        properties = {
          title  = "[ElastiCache] Memory & Cache Performance (cluster: ${coalesce(cluster.label, cluster.name)})"
          view   = "timeSeries"
          region = coalesce(cluster.region, var.default_region)

          yAxis = {
            left = {
              min = 0
            }

            right = {
              label     = "Percent"
              showUnits = false
              min       = 0
              max       = 100
            }
          }

          metrics = concat(
            [
              [
                "AWS/ElastiCache",
                "FreeableMemory",
                "CacheClusterId",
                cluster.name,
                { yAxis = "left" }
              ],
              [
                "AWS/ElastiCache",
                "SwapUsage",
                "CacheClusterId",
                cluster.name,
                { yAxis = "left" }
              ],
              [
                {
                  expression = local.elasticache_memcached_hit_rate_expr
                  label      = "CacheHitRate"
                  yAxis      = "right"
                }
              ]
            ],
            [for metric in local.elasticache_memcached_hit_metrics :
              [
                "AWS/ElastiCache",
                metric,
                "CacheClusterId",
                cluster.name,
                { id = lower(metric), visible = false }
              ]
            ],
            [for metric in local.elasticache_memcached_miss_metrics :
              [
                "AWS/ElastiCache",
                metric,
                "CacheClusterId",
                cluster.name,
                { id = lower(metric), visible = false }
              ]
            ]
          )
        }
      },
      {
        type = "metric"

        properties = {
          title  = "[ElastiCache] Commands (cluster: ${coalesce(cluster.label, cluster.name)})"
          view   = "timeSeries"
          region = coalesce(cluster.region, var.default_region)

          yAxis = {
            left = {
              min = 0
            }
          }

          metrics = [
            [
              "AWS/ElastiCache",
              "CmdGet",
              "CacheClusterId",
              cluster.name,
              { stat = "Sum" }
            ],
            [
              "AWS/ElastiCache",
              "CmdSet",
              "CacheClusterId",
              cluster.name,
              { stat = "Sum" }
            ]
          ]
        }
      }
    ]
  ]...)
}
