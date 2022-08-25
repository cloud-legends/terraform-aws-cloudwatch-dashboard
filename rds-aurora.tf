locals {
  rds_aurora_widgets = concat([], [
    for cluster in var.rds_aurora_clusters :
    [
      {
        type = "metric"

        properties = {
          title  = "[RDS] CPU & Connections (cluster: ${coalesce(cluster.label, cluster.name)})"
          view   = "timeSeries"
          region = coalesce(cluster.region, local.default_region)

          yAxis = {
            left = {
              min = 0
              max = 100
            }
          }

          metrics = [
            [
              "AWS/RDS",
              "CPUUtilization",
              "DBClusterIdentifier",
              cluster.name,
              { yAxis = "left" }
            ],
            [
              "AWS/RDS",
              "DatabaseConnections",
              "DBClusterIdentifier",
              cluster.name,
              { yAxis = "right" }
            ]
          ]
        }
      },
      {
        type = "metric"

        properties = {
          title  = "[RDS] Latency (cluster: ${coalesce(cluster.label, cluster.name)})"
          view   = "timeSeries"
          region = coalesce(cluster.region, local.default_region)

          yAxis = {
            left = {
              min = 0
            }
          }

          metrics = [
            ["AWS/RDS", "ReadLatency", "DBClusterIdentifier", cluster.name],
            ["AWS/RDS", "WriteLatency", "DBClusterIdentifier", cluster.name]
          ]
        }
      },
      {
        type = "metric"

        properties = {
          title  = "[RDS] IOPS and Throughput (cluster: ${coalesce(cluster.label, cluster.name)})"
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
              "AWS/RDS",
              "ReadIOPS",
              "DBClusterIdentifier",
              cluster.name,
              { yAxis = "left" }
            ],
            [
              "AWS/RDS",
              "WriteIOPS",
              "DBClusterIdentifier",
              cluster.name,
              { yAxis = "left" }
            ],
            [
              "AWS/RDS",
              "ReadThroughput",
              "DBClusterIdentifier",
              cluster.name,
              { yAxis = "right" }
            ],
            [
              "AWS/RDS",
              "WriteThroughput",
              "DBClusterIdentifier",
              cluster.name,
              { yAxis = "right" }
            ]
          ]
        }
      }
    ]
  ]...)
}
