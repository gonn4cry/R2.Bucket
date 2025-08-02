#!/bin/bash

endpoint=$1
bucket=$2
expires=3600  

aws s3api list-objects-v2 \
    --endpoint-url "$endpoint" \
    --bucket "$bucket" \
    --query "Contents[].Key" \
    --output text \
    | while read -r key; do
        echo "Generating URL for: $key"
        aws s3 presign \
            --endpoint-url "$endpoint" \
            "s3://$bucket/$key" \
            --expires-in "$expires"
      done
