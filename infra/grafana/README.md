Here is the Grafana dashboards provided as is I have it in our Grafana. It may not work for yours Grafana and monitoring system setup, since it may have different datasources and exporters with different metric names and labels. Feel free to modify to fit your Grafana and Prometheus/Victoriametrics setup.

kubernetes-pods.json Kubernetes / Pods dashboard to visualize basic metrics for pods: CPU Requests/Limits/Usage, Memory Requests/Limits/Usage, IOPS Read/Write, etc.
pgbouncer.json Pgbouncer dashboard to see how pgbouncer works.

## Also some helpful dashboards to maintain and troubleshoot your Postgres
Percona PostgreSQL Queries Overview (Designed for PMM) and PostgreSQL Query Drill-Down (Designed for PMM)
https://grafana.com/grafana/dashboards/10017-postgresql-queries-overview/
https://grafana.com/grafana/dashboards/10018-postgresql-query-drill-down/
Extremely useful, but designed for Percona PMM monitoring solution, may be hard to make it work with your own monitoring setup.

