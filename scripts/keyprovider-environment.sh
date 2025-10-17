#!/usr/bin/env sh
set -e

TOFU_STATE_KEY="$(echo $TOFU_STATE_KEY | base64)"

echo '{"magic": "OpenTofu-External-Key-Provider", "version": 1}'

cat <<JSON
{
  "keys": {
    "encryption_key": "$TOFU_STATE_KEY",
    "decryption_key": "$TOFU_STATE_KEY"
  },
  "meta": {
    "external_data": {}
  }
}
JSON
