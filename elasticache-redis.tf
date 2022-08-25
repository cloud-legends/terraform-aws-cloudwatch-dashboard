locals {
  elasticache_redis_widgets = concat([], [
    for cluster in var.elasticache_redis_clusters :
    [
      {
        type = "metric"

        properties = {
          title  = "[ElastiCache] Connections & CPU (cluster: ${coalesce(cluster.label, cluster.name)})"
          view   = "timeSeries"
          region = coalesce(cluster.region, local.default_region)

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
          region = coalesce(cluster.region, local.default_region)

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
              "AWS/ElastiCache",
              "CacheHitRate",
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
          title  = "[ElastiCache] Commands & Latency (cluster: ${coalesce(cluster.label, cluster.name)})"
          view   = "timeSeries"
          region = coalesce(cluster.region, local.default_region)

          yAxis = {
            left = {
              min = 0
            }

            right = {
              min = 0
            }
          }

          metrics = [
            [
              "AWS/ElastiCache",
              "GetTypeCmds",
              "CacheClusterId",
              cluster.name,
              { yAxis = "left", stat = "Sum" }
            ],
            [
              "AWS/ElastiCache",
              "SetTypeCmds",
              "CacheClusterId",
              cluster.name,
              { yAxis = "left", stat = "Sum" }
            ],
            [
              "AWS/ElastiCache",
              "GetTypeCmdsLatency",
              "CacheClusterId",
              cluster.name,
              { yAxis = "right" }
            ],
            [
              "AWS/ElastiCache",
              "SetTypeCmdsLatency",
              "CacheClusterId",
              cluster.name,
              { yAxis = "right" }
            ]
          ]
        }
      }
    ]
  ]...)
}
