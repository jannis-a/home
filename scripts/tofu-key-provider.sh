#!/usr/bin/env sh
set -eu

# ---- OpenTofu external key provider protocol ----
# 1) Emit header (exactly once)
echo '{"magic":"OpenTofu-External-Key-Provider","version":1}'

# 2) Read stdin (metadata or null)
META="$(cat)"

# 3) Require passphrase from environment
: "${TOFU_STATE_KEY:?TOFU_STATE_KEY is not set}"

# Base64-encode passphrase bytes deterministically
KEY_B64="$(printf %s "$TOFU_STATE_KEY" | base64 | tr -d '\n')"

# 4) Emit keys
if [ "$META" = "null" ]; then
  # encrypt-only
  printf '{"keys":{"encryption_key":"%s"},"meta":{"external_data":{}}}\n' "$KEY_B64"
else
  # decrypt + encrypt
  printf '{"keys":{"encryption_key":"%s","decryption_key":"%s"},"meta":{"external_data":{}}}\n' "$KEY_B64" "$KEY_B64"
fi
