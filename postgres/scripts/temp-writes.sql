-- Find queries that are writing to temp files.
-- Other way - Loki queries: {app="postgres", log~="temporary file"}, {namespace="production-db", pod=~"postgres.*"} |= "temporary"
-- set log_temp_files=0 in postgresql.conf to enable logging of temp files
SELECT * FROM pg_stat_statements WHERE temp_blks_read > 0 OR temp_blks_written > 0;
