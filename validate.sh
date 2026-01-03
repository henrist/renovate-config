#!/bin/bash
set -eu -o pipefail

echo "Fetching latest JSON Schema"
curl -s https://docs.renovatebot.com/renovate-schema.json > renovate-schema.json

for x in $(ls -1 *.json | grep -v "^package.json$" | grep -v "^package-lock.json$"); do
  echo "Validating $x"
  ./node_modules/.bin/ajv -s renovate-schema.json -d "$x" -c ajv-formats --strict=false
done
