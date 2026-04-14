#!/bin/sh

echo "$1"
python3 load_tweets.py --db=postgresql://postgres:pass@localhost:2089/postgres --inputs="$1"
