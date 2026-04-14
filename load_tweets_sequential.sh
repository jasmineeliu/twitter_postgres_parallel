#!/bin/bash

files=$(find data -type f)
echo '================================================================================'
echo 'load denormalized'
echo '================================================================================'
time for file in $files; do
    echo
    zcat "$file" | sed 's/\\u0000//g' | psql "postgresql://postgres:pass@localhost:1089/postgres" -c "COPY tweets_jsonb (data) FROM STDIN csv quote e'\x01' delimiter e'\x02';"
done

echo '================================================================================'
echo 'load pg_normalized'
echo '================================================================================'
time for file in $files; do
    echo
    python3 load_tweets.py --inputs="$file" --db postgresql://postgres:pass@localhost:2089/postgres
done

echo '================================================================================'
echo 'load pg_normalized_batch'
echo '================================================================================'
time for file in $files; do
    python3 -u load_tweets_batch.py --db=postgresql://postgres:pass@localhost:3089/ --inputs $file
done
