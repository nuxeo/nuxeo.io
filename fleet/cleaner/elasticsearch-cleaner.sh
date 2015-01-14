#!/bin/sh -

# Delete ElasticSearch index
curl -XDELETE "http://localhost:9200/${SERVICE_ID}"
