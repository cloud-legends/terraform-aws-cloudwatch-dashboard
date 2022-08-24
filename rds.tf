locals {
  rds_widgets = concat([], [
    for database in var.rds_databases :
    [
      {
        type = "metric"

        properties = {
          title  = "[RDS] CPU & Connections (database: ${coalesce(database.label, database.name)})"
          view   = "timeSeries"
          region = coalesce(database.region, var.default_region)

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
              database.name,
              { yAxis = "left" }
            ],
            [
              "AWS/RDS",
              "DatabaseConnections",
              "DBInstanceIdentifier",
              database.name,
              { yAxis = "right" }
            ]
          ]
        }
      },
      {
        type = "metric"

        properties = {
          title  = "[RDS] Latency (database: ${coalesce(database.label, database.name)})"
          view   = "timeSeries"
          region = coalesce(database.region, var.default_region)

          yAxis = {
            left = {
              min = 0
            }
          }

          metrics = [
            ["AWS/RDS", "ReadLatency", "DBInstanceIdentifier", database.name],
            ["AWS/RDS", "WriteLatency", "DBInstanceIdentifier", database.name]
          ]
        }
      },
      {
        type = "metric"

        properties = {
          title  = "[RDS] IOPS and Throughput (database: ${coalesce(database.label, database.name)})"
          view   = "timeSeries"
          region = coalesce(database.region, var.default_region)

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
              database.name,
              { yAxis = "left" }
            ],
            [
              "AWS/RDS",
              "WriteIOPS",
              "DBInstanceIdentifier",
              database.name,
              { yAxis = "left" }
            ],
            [
              "AWS/RDS",
              "ReadThroughput",
              "DBInstanceIdentifier",
              database.name,
              { yAxis = "right" }
            ],
            [
              "AWS/RDS",
              "WriteThroughput",
              "DBInstanceIdentifier",
              database.name,
              { yAxis = "right" }
            ]
          ]
        }
      }
    ]
  ]...)
}
