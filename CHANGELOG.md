# Changelog

All notable changes to the hosted Skrapp MCP server are recorded here. The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and the project uses [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## 1.5.3 - 2026-11-13

### Changed

- Internal: data gateway calls record which MCP tool made each query. No change to tool inputs or outputs.

## 1.5.2 - 2026-11-12

### Changed

- Internal: data gateway calls are tagged for request analytics. No change to tool inputs or outputs.

## 1.5.1 - 2026-11-12

### Added

- `get_list_leads` returns `resolvedLinkedinUrl`, the public LinkedIn profile when known, next to `linkedinUrl` as saved.

## 1.5.0 - 2026-11-12

### Added

- Credit and rate-limit refusals end with a link to the Skrapp pricing page, in the text and as `structuredContent.upgrade_url`.

### Changed

- The daily search cap refusal is a structured `rate_limited` error with `limit`, `reset_at` (00:00 UTC) and `retryable: false`.
- The server instructions ask the assistant to give the user `upgrade_url` as is.

## 1.4.2 - 2026-11-10

### Fixed

- The per-client context is now carried into every tool handler, including bulk workers; before this, most upstream calls fell back to the plain `mcp` tag.

## 1.4.1 - 2026-11-10

### Fixed

- Codex requests are tagged `mcp-codex` instead of `mcp-chatgpt` (its User-Agent also contains `openai`).

## 1.4.0 - 2026-11-10

### Added

- Every upstream call carries the calling assistant (`mcp-claude`, `mcp-chatgpt`, `mcp-codex`, ...) so usage can be attributed per client.

### Changed

- OAuth refresh tokens now last 90 days.

## 1.3.0 - 2026-11-09

### Changed

- `search_companies` is aligned with the Companies Search API.

## 1.2.0 - 2026-11-09

### Changed

- Sign-in is now required on every request, including `initialize`.

## 1.1.0 - 2026-11-09

### Added

- Per-account rate limits: 250 read, 250 spend and 25 bulk calls per minute.

## 1.0.0 - 2026-11-09

### Added

- First major release: 21 tools, OAuth 2.1 (PKCE, dynamic client registration), prompts and resources.
