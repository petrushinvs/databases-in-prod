-- Show all locks that are currently waiting (not granted) in the database.
SELECT 
    pg_stat_activity.pid,
    pg_stat_activity.usename AS username,
    pg_stat_activity.datname AS database_name,
    pg_stat_activity.query AS locked_query,
    pg_stat_activity.query_start,
    pg_locks.locktype,
    pg_locks.mode,
    pg_locks.granted,
    pg_locks.relation::regclass AS locked_relation,
    pg_stat_activity.wait_event_type AS wait_event_type,
    pg_stat_activity.wait_event AS wait_event
FROM 
    pg_stat_activity
JOIN 
    pg_locks ON pg_stat_activity.pid = pg_locks.pid
WHERE 
    pg_stat_activity.state = 'active'  -- Currently running queries
    AND pg_locks.granted = false       -- Only include locks that are waiting (not granted)
    -- The query filters to show only waiting locks (granted = false), but you can remove this condition if you also want to see granted locks.
    AND pg_stat_activity.query NOT ILIKE '%pg_stat_activity%'  -- Exclude this query itself
ORDER BY 
    pg_stat_activity.query_start;

-- blocked queries
select pid, usename, pg_blocking_pids(pid) as blocked_by, query as blocked_query
from pg_stat_activity
where cardinality(pg_blocking_pids(pid)) > 0;
