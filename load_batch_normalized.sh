#!/bin/sh

python3 -u load_tweets_batch.py --db=postgresql://postgres:pass@localhost:3089/postgres --inputs="$1"

