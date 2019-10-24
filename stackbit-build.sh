#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://stg-api.stackbit.com/project/5db1ad0c85b735001965d62f/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://stg-api.stackbit.com/pull/5db1ad0c85b735001965d62f 
fi
curl -s -X POST https://stg-api.stackbit.com/project/5db1ad0c85b735001965d62f/webhook/build/ssgbuild > /dev/null
hugo
curl -s -X POST https://stg-api.stackbit.com/project/5db1ad0c85b735001965d62f/webhook/build/publish > /dev/null
