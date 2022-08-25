locals {
  ecs_widgets = concat([], [
    for cluster in var.ecs_clusters :
    [
      {
        type = "metric"

        properties = {
          title  = "[ECS] CPU/Memory (cluster: ${coalesce(cluster.label, cluster.name)})"
          view   = "timeSeries"
          region = coalesce(cluster.region, local.default_region)

          yAxis = {
            left = {
              min = 0
              max = 100
            }
          }

          metrics = [
            ["AWS/ECS", "CPUUtilization", "ClusterName", cluster.name],
            ["AWS/ECS", "MemoryUtilization", "ClusterName", cluster.name]
          ]
        }
      },
      {
        type = "metric"

        properties = {
          title  = "[ECS] CPU Utilization per service (cluster: ${coalesce(cluster.label, cluster.name)})"
          view   = "timeSeries"
          region = coalesce(cluster.region, local.default_region)

          yAxis = {
            left = {
              min = 0
              max = 100
            }
          }

          metrics = [
            for service in cluster.services :
            [
              "AWS/ECS",
              "CPUUtilization",
              "ServiceName",
              service.name,
              "ClusterName",
              cluster.name,
              { label = coalesce(service.label, service.name) }
            ]
          ]
        }
      },
      {
        type = "metric"

        properties = {
          title  = "[ECS] Memory Utilization per service (cluster: ${coalesce(cluster.label, cluster.name)})"
          view   = "timeSeries"
          region = coalesce(cluster.region, local.default_region)

          yAxis = {
            left = {
              min = 0
              max = 100
            }
          }

          metrics = [
            for service in cluster.services :
            [
              "AWS/ECS",
              "MemoryUtilization",
              "ServiceName",
              service.name,
              "ClusterName",
              cluster.name,
              { label = coalesce(service.label, service.name) }
            ]
          ]
        }
      }
    ]
  ]...)
}
