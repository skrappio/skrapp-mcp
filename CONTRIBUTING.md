# Contributing

This repository holds documentation, the MCP Registry manifest and examples for the hosted Skrapp MCP server. The service itself is not developed here, so contributions are limited to docs, examples and the manifest. Feature requests for the server are welcome as issues but are handled by the Skrapp team.

## Before you open a pull request

1. Open an issue for anything larger than a typo or a broken link.
2. Keep one topic per pull request, with a [Conventional Commits](https://www.conventionalcommits.org) title such as `docs: fix Cursor install link`.
3. Use only environment variable placeholders (`$SKRAPP_API_KEY`) in examples. Never commit a real key or token.
4. Record user-visible server changes in [CHANGELOG.md](CHANGELOG.md) only when they are released by Skrapp.

## Run the checks locally

Node 20 or newer is required.

```bash
# Markdown lint
npx --yes markdownlint-cli2@0.18.1

# server.json against the schema named in its $schema field
curl -sSf "$(jq -r '."$schema"' server.json)" -o /tmp/server.schema.json
npx --yes -p ajv-cli@5.0.0 -p ajv-formats@3.0.1 ajv validate \
  --spec=draft7 --strict=false -c ajv-formats -s /tmp/server.schema.json -d server.json

# JSON examples parse (dotglob picks up .mcp.json)
shopt -s dotglob  # bash
for f in examples/*.json examples/apikey/*.json; do jq empty "$f"; done

# TOML examples parse (Python 3.11 or newer)
python3 -c 'import sys,tomllib; [tomllib.load(open(f,"rb")) for f in sys.argv[1:]]' \
  examples/codex.config.toml examples/apikey/codex.config.toml
```

The same checks run in CI, together with a link check ([lychee](https://github.com/lycheeverse/lychee)). The `live-check` workflow probes the public endpoints weekly.

## Conduct

Everyone taking part follows the [Code of Conduct](CODE_OF_CONDUCT.md). By contributing you agree your contribution is released under the [MIT License](LICENSE).
