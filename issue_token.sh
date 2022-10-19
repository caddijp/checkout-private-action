#!/usr/bin/env bash

name=$1
github_app_id=$2
github_app_key_path=$3

base64_option="-w 0"
header=$(echo -n '{"alg":"RS256","typ":"JWT"}' | base64 ${base64_option})

now=$(date "+%s")
iat=$((${now} - 60))
exp=$((${now} + (10 * 60)))
payload=$(echo -n "{\"iat\":${iat},\"exp\":${exp},\"iss\":${github_app_id}}" | base64 ${base64_option})

unsigned_token="${header}.${payload}"

signed_token=$(echo -n "${unsigned_token}" | openssl dgst -binary -sha256 -sign "${github_app_key_path}" | base64 ${base64_option})

jwt="${unsigned_token}.${signed_token}"

installation_id=$(
  curl -s -X GET \
    -H "Authorization: Bearer ${jwt}" \
    -H "Accept: application/vnd.github.v3+json" \
    "https://api.github.com/app/installations" \
  | jq -r ".[] | select(.account.login == \"${name}\") | .id"
)

access_token=$(
  curl -s -X POST \
    -H "Authorization: Bearer ${jwt}" \
    -H "Accept: application/vnd.github.v3+json" \
    "https://api.github.com/app/installations/${installation_id}/access_tokens" \
  | jq -r ".token"
)

echo "access_token=$(echo $access_token)" >> $GITHUB_OUTPUT