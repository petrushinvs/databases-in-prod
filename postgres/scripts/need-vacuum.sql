-- Find tables that need a VACUUM.

SELECT
    schemaname, relname AS table_name,
    n_dead_tup AS dead_tuples, n_live_tup AS live_tuples,
    CASE WHEN n_live_tup > 0 THEN
        round((n_dead_tup::numeric / n_live_tup) * 100, 2)
    ELSE 0 END AS dead_tuple_ratio
FROM pg_stat_user_tables ORDER BY dead_tuple_ratio DESC
LIMIT 10;
