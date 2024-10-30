-- Time consuming queries
-- Good for finding queries that are making the biggest load to database.
-- Good idea to pass the results to Prometheus metrics to draw a graphs, if queries times are growing.
select
    t1.queryid,
    t3.datname,
    t1.query,
    t1.calls,
    (t1.total_plan_time + t1.total_exec_time) / 1000 AS total_time_seconds,
    (t1.min_plan_time + t1.min_exec_time) / 1000 AS min_time_seconds,
    (t1.max_plan_time + t1.max_exec_time) / 1000 AS max_time_seconds,
    (t1.mean_plan_time + t1.mean_exec_time) / 1000 AS mean_time_seconds,
    (t1.stddev_plan_time + t1.stddev_exec_time) / 1000 AS stddev_time_seconds,
    t1.rows,
    t1.temp_blks_read,
    t1.temp_blks_written
FROM
    pg_stat_statements t1
    JOIN pg_roles t2 ON (t1.userid = t2.oid)
    JOIN pg_database t3 ON (t1.dbid = t3.oid)
WHERE
    t1.queryid IS NOT NULL
    and t3.datname != 'postgres'
order by t1.calls desc;
-- order by total_time_seconds desc;
-- order by max_time_seconds desc;
