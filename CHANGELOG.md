# Changelog

All notable changes to the hosted Skrapp MCP server are recorded here. The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and the project uses [Semantic Versioning](https://semver.org/spec/v2.0.0.html). A release date is given where it is known.

## 1.4.2

### Fixed

- Context tagging fix for per-client context.

## 1.4.1

### Fixed

- Context tagging fix for per-client context.

## 1.4.0

### Added

- Per-client context.

### Changed

- OAuth refresh tokens now last 90 days.

## 1.3.0

### Changed

- `search_companies` is aligned with the Companies Search API.

## 1.2.0

### Changed

- Sign-in is now required on every request, including `initialize`.

## 1.1.0

### Added

- Per-account rate limits: 250 read, 250 spend and 25 bulk calls per minute.

## 1.0.0 - 2026-11-09

### Added

- First major release: 21 tools, OAuth 2.1 (PKCE, dynamic client registration), prompts and resources.
