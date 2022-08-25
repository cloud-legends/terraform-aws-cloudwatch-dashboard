locals {
  rds_widgets = concat([], [
    for instance in var.rds_instances :
    [
      {
        type = "metric"

        properties = {
          title  = "[RDS] CPU & Connections (instance: ${coalesce(instance.label, instance.name)})"
          view   = "timeSeries"
          region = coalesce(instance.region, local.default_region)

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
              "DBInstanceIdentifier",
              instance.name,
              { yAxis = "left" }
            ],
            [
              "AWS/RDS",
              "DatabaseConnections",
              "DBInstanceIdentifier",
              instance.name,
              { yAxis = "right" }
            ]
          ]
        }
      },
      {
        type = "metric"

        properties = {
          title  = "[RDS] Latency (instance: ${coalesce(instance.label, instance.name)})"
          view   = "timeSeries"
          region = coalesce(instance.region, local.default_region)

          yAxis = {
            left = {
              min = 0
            }
          }

          metrics = [
            ["AWS/RDS", "ReadLatency", "DBInstanceIdentifier", instance.name],
            ["AWS/RDS", "WriteLatency", "DBInstanceIdentifier", instance.name]
          ]
        }
      },
      {
        type = "metric"

        properties = {
          title  = "[RDS] IOPS and Throughput (instance: ${coalesce(instance.label, instance.name)})"
          view   = "timeSeries"
          region = coalesce(instance.region, local.default_region)

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
              "DBInstanceIdentifier",
              instance.name,
              { yAxis = "left" }
            ],
            [
              "AWS/RDS",
              "WriteIOPS",
              "DBInstanceIdentifier",
              instance.name,
              { yAxis = "left" }
            ],
            [
              "AWS/RDS",
              "ReadThroughput",
              "DBInstanceIdentifier",
              instance.name,
              { yAxis = "right" }
            ],
            [
              "AWS/RDS",
              "WriteThroughput",
              "DBInstanceIdentifier",
              instance.name,
              { yAxis = "right" }
            ]
          ]
        }
      }
    ]
  ]...)
}
