-- Currently running queries in PostgreSQL
-- To detect long-running queries in PostgreSQL and potential deadlocks
-- watch -n 5 "psql -U your_username -d your_database -c \"SELECT pid, usename AS username, datname AS database_name, state, query_start, now() - query_start AS query_duration, wait_event_type, wait_event, query FROM pg_stat_activity WHERE state = 'active' AND now() - query_start > INTERVAL '15 seconds' AND query NOT ILIKE '%pg_stat_activity%' ORDER BY query_duration DESC;\""
SELECT
    pid,
    usename AS username,
    datname AS database_name,
    state,
    query_start,
    now() - query_start AS query_duration,
    wait_event_type,
    wait_event,
    query
FROM
    pg_stat_activity
WHERE
    state = 'active'                     -- Only running queries
    AND now() - query_start > INTERVAL '15 seconds'  -- Duration filter
    AND query NOT ILIKE '%pg_stat_activity%'  -- Exclude this query itself
ORDER BY
    query_duration DESC;                 -- Longest-running queries first
