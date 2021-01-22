#!/bin/bash

sed -i "s/^.*max_prepared_transactions\s*=\s*\(.*\)$/max_prepared_transactions = 100/" "$PGDATA"/postgresql.conf
sed -i "s/^.*shared_buffers\s*=\s*\(.*\)$/shared_buffers = 1GB/" "$PGDATA"/postgresql.conf
sed -i "s/^.*maintenance_work_mem\s*=\s*\(.*\)$/maintenance_work_mem = 256MB/" "$PGDATA"/postgresql.conf
sed -i "s/^# *work_mem\s*=\s*\(.*\)$/work_mem = 16MB/" "$PGDATA"/postgresql.conf
sed -i "s/^.*effective_cache_size\s*=\s*\(.*\)$/effective_cache_size = 2600MB/" "$PGDATA"/postgresql.conf
sed -i "s/^.*effective_io_concurrency\s*=\s*\(.*\)$/effective_io_concurrency = 200/" "$PGDATA"/postgresql.conf
sed -i "s/^.*checkpoint_completion_target\s*=\s*\(.*\)$/checkpoint_completion_target = 0.9/" "$PGDATA"/postgresql.conf