#!/bin/bash

shopt -s nullglob
for f in *.yml
do
  echo "File: $f" 
  docker run -it \
  -v $(pwd)/policies/:/custodian/policies/ \
  -v $(cd ~ && pwd)/.aws/credentials:/custodian/.aws/credentials \
  -v $(cd ~ && pwd)/.aws/config:/custodian/.aws/config \
  custodian:latest run -v -s s3://cloudcustodian-lambda-bucket-logs /custodian/policies/$f.yml --profile endava --region us-west-2
done; 

# docker run -it \
#   -v $(pwd)/policies/:/custodian/policies/ \
#   -v $(cd ~ && pwd)/.aws/credentials:/custodian/.aws/credentials \
#   -v $(cd ~ && pwd)/.aws/config:/custodian/.aws/config \
#   custodian:latest run -v -s s3://cloudcustodian-lambda-bucket-logs /custodian/policies/*.yml --profile endava --region us-west-2