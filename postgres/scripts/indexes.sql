-- Unused indexes
SELECT 
    relname AS table_name, 
    indexrelname AS index_name, 
    pg_size_pretty(pg_relation_size(indexrelid)) AS index_size
FROM pg_stat_user_indexes
WHERE idx_scan = 0  -- No scans
ORDER BY pg_relation_size(indexrelid) DESC;

-- Total size of unused indexes
SELECT 
    pg_size_pretty(SUM(pg_relation_size(indexrelid))) AS indexes_size
FROM pg_stat_user_indexes
WHERE idx_scan = 0;

-- Index usage vs seq scan
SELECT
    relname AS table_name,
    seq_scan, seq_tup_read,
    idx_scan, idx_tup_fetch,
    round(100 * idx_scan::numeric / NULLIF(seq_scan + idx_scan, 0), 2) AS index_usage_percent
FROM pg_stat_user_tables
ORDER BY index_usage_percent DESC NULLS LAST;

-- Duplicate indexes covers the same columns
SELECT 
    indrelid::regclass AS table_name,
    array_agg(indexrelid::regclass) AS duplicate_indexes
FROM pg_index
GROUP BY indrelid, indkey
HAVING COUNT(*) > 1;
