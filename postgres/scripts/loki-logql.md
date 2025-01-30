Loki logql tips

Query to get long running query log entries with duration more than 1 second
{namespace="production-db", pod="postgres-production"} |~ "duration: \\d{4,}"

Query to get long running query log entries with duration more than 100 milliseconds
{namespace="production-db", pod="postgres-production"} |~ "duration: \\d{3,}"
