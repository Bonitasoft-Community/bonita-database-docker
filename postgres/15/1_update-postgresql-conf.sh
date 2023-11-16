#!/bin/bash

# set max_prepared_transactions to 100
sed -i "s/^.*max_prepared_transactions\s*=\s*\(.*\)$/max_prepared_transactions = 100/" "$PGDATA"/postgresql.conf
