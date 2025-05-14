#! /bin/bash

HOST=$1
echo HOST: $HOST
for EXT in key crt ; do
    CERT=$(sed 's/$/\\n/' $HOST.$EXT | tr -d '\n')
    URL=https://$HOST/api/9/http/keyvals/ssl_$EXT
    echo {\"$HOST\":\""$CERT"\"} | curl -kvH "Content-Type: application/json" -d @- $URL
done
