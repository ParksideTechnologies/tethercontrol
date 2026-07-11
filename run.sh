#!/usr/bin/with-contenv bashio
set -euo pipefail

UI_PORT="$(bashio::config 'ui_port')"
LICENCE_KEY="$(bashio::config 'licence_key')"

if [ -z "${UI_PORT}" ]; then
  UI_PORT="5180"
fi

bashio::log.info "UI port: ${UI_PORT}"

APP_BIN="/app/TCBin"
DATA_BIN="/data/TCBin"

cp -f "${APP_BIN}" "${DATA_BIN}"
chmod +x "${DATA_BIN}"
rm -rf /data/UI
if [ -d /app/UI ]; then
  cp -a /app/UI /data/UI
fi

export ASPNETCORE_URLS="http://0.0.0.0:${UI_PORT}"
export Logging__LogLevel__Default="Information"
export Logging__LogLevel__Microsoft="Warning"
export Logging__LogLevel__Microsoft_AspNetCore="Warning"
export Core__SimGpioChip="/dev/gpiochip0"
export Core__SimGpioPin="27"
export Core__SimGpioActiveLow="true"
export Licensing__LicenceKey="${LICENCE_KEY}"
export DOTNET_BUNDLE_EXTRACT_BASE_DIR="/tmp/.net-bundle"

# Ensure stale extracted single-file payloads do not survive between updates.
rm -rf /root/.net/TCBin || true
mkdir -p "${DOTNET_BUNDLE_EXTRACT_BASE_DIR}"

exec "${DATA_BIN}"
