#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

PDS_ENV_FILE=${PDS_ENV_FILE:-"/pds/pds.env"}
export $(cat "${PDS_ENV_FILE}" | grep -v ^# | xargs) >/dev/null

curl \
  --fail \
  --silent \
  --show-error \
  --request POST \
  --user "admin:${PDS_ADMIN_PASSWORD}" \
  --header "Content-Type: application/json" \
  --data '{"useCount": 1}' \
  "https://${PDS_HOSTNAME}/xrpc/com.atproto.server.createInviteCode" | jq --raw-output '.code'
