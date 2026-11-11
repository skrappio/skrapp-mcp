#!/usr/bin/env bash
# List the tools of the Skrapp MCP server with an API key.
# Usage: SKRAPP_API_KEY=<your-skrapp-api-key> ./curl.sh
set -euo pipefail
: "${SKRAPP_API_KEY:?set SKRAPP_API_KEY in your environment}"

curl -sS -X POST https://mcp.skrapp.io/ \
  -H "X-Access-Key: ${SKRAPP_API_KEY}" \
  -H "Content-Type: application/json" \
  -H "Accept: application/json, text/event-stream" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/list"}'
