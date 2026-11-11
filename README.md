# Skrapp MCP

Skrapp MCP is the hosted [Model Context Protocol](https://modelcontextprotocol.io) server for [Skrapp](https://skrapp.io). It lets Claude, ChatGPT, Perplexity, Grok, Mistral, Microsoft Copilot, Codex, Cursor, VS Code and any other MCP client find and verify professional emails, look up phone numbers, search and enrich companies, and manage Skrapp lists, in plain language.

This repository is the public home of the service: documentation, registry manifest, examples, changelog and support. It does not contain the service source code.

## Server

| | |
| --- | --- |
| URL | `https://mcp.skrapp.io/` |
| Transport | Streamable HTTP, `POST` to the root |
| Sessions | Stateless, JSON responses |
| Authentication | OAuth 2.1 (default) or Skrapp API key |
| Tools | 21, plus 3 prompts and 4 resources |
| Cost | Same Skrapp credits and prices as the app, no extra fee |

Full guide: <https://skrapp.io/mcp>. Tool reference: <https://skrapp.io/api#mcp>. The same content as Markdown: <https://skrapp.io/mcp.md>.

## Quick start

You need a Skrapp account (any plan, including the free one) with an active Skrapp API key: OAuth sign-in only works for accounts that have one. Create or view your key at <https://app.skrapp.io/integrations>.

### Chat assistants

Add Skrapp as a custom connector, paste `https://mcp.skrapp.io/` as the server URL, keep OAuth as the authentication and sign in with your Skrapp account. No API key is pasted into the assistant. Custom connectors require a paid plan on Claude, ChatGPT (Plus, Pro, Business, Enterprise) and Perplexity (Pro, Max, Enterprise).

| Assistant | Where | Step-by-step |
| --- | --- | --- |
| Claude | Settings, Customize, Connectors, Add custom connector | <https://skrapp.io/mcp#connect-claude> |
| ChatGPT | Plugins, Add, Add custom MCP server | <https://skrapp.io/mcp#connect-chatgpt> |
| Perplexity | Settings, Connectors, Add custom, Remote | <https://skrapp.io/mcp#connect-perplexity> |
| Grok | Connectors, New Connector, Custom | <https://skrapp.io/mcp#connect-grok> |
| Mistral (Le Chat) | Connectors, Add Connector, Custom MCP Connector | <https://skrapp.io/mcp#connect-mistral> |
| Microsoft Copilot | Copilot Studio, Tools, Model Context Protocol, OAuth 2.0 with dynamic discovery | <https://skrapp.io/mcp#connect-copilot> |

### Code tools

| Client | Install |
| --- | --- |
| Claude Code | `claude mcp add --transport http skrapp https://mcp.skrapp.io/`, then `/mcp` inside Claude Code to sign in |
| Cursor | [Add to Cursor](cursor://anysphere.cursor-deeplink/mcp/install?name=skrapp&config=eyJ1cmwiOiJodHRwczovL21jcC5za3JhcHAuaW8vIn0=), or [`examples/cursor.mcp.json`](examples/cursor.mcp.json) as `.cursor/mcp.json` |
| VS Code | [Add to VS Code](https://insiders.vscode.dev/redirect/mcp/install?name=skrapp&config=%7B%22type%22%3A%22http%22%2C%22url%22%3A%22https%3A%2F%2Fmcp.skrapp.io%2F%22%7D), or [`examples/vscode.mcp.json`](examples/vscode.mcp.json) as `.vscode/mcp.json` |
| Codex | `codex mcp add skrapp --url https://mcp.skrapp.io/`, then `codex mcp login skrapp`; or [`examples/codex.config.toml`](examples/codex.config.toml) in `~/.codex/config.toml` |
| Claude Code (shared) | [`examples/.mcp.json`](examples/.mcp.json) at your project root |

Cursor, VS Code and Codex sign you in when they first load the server.

## Authentication

**OAuth 2.1 (default).** Give the client only the server URL. It discovers the authorization server from `/.well-known/oauth-protected-resource`, registers itself (dynamic client registration, public client), and opens the Skrapp consent page; you approve once. It then holds a one-hour access token and a rotating refresh token (valid 90 days) bound to your account, using Authorization Code with PKCE (`S256`). Revoke access at any time from your Skrapp account or at `/oauth/revoke`.

| Endpoint | URL |
| --- | --- |
| Protected resource metadata | `https://mcp.skrapp.io/.well-known/oauth-protected-resource` |
| Authorization server metadata | `https://mcp.skrapp.io/.well-known/oauth-authorization-server` |
| Authorization | `https://app.skrapp.io/oauth/authorize` |
| Token | `https://mcp.skrapp.io/oauth/token` |
| Client registration | `https://mcp.skrapp.io/oauth/clients/register` |
| Revocation | `https://mcp.skrapp.io/oauth/revoke` |

**API key.** For scripts, CI and in-house agents that cannot open a browser. Send the same key as the REST API in `X-Access-Key`; `X-Api-Key` and `Authorization: Bearer` are also accepted. Every request needs a credential, including `initialize`: an anonymous request gets `401` with a `WWW-Authenticate` header that points at the protected resource metadata.

Keep keys in the environment, never in committed files:

```bash
export SKRAPP_API_KEY="<your-skrapp-api-key>"
```

Ready-made API key configs live in [`examples/apikey/`](examples/apikey/), and a request example in [`examples/curl.sh`](examples/curl.sh).

## Tools

Costs are Skrapp credits and match the REST API. They can change: call `get_account` or read the `skrapp://pricing/tool-costs` resource for live pricing.

| Tool | Cost | Purpose |
| --- | --- | --- |
| `get_account` | Free | Plan, credit balance and cost summary. Call it first |
| `get_company` | Free | Company snapshot by domain, name or id |
| `search_leads` | Free | Find people by title, company, location and more; each new filter set uses one daily search |
| `search_companies` | Free | Company search with the Companies Search API filters |
| `find_lists` | Free | Your lists, with id and size |
| `get_list` | Free | One list by id |
| `get_list_leads` | Free | Leads saved in a list, paged |
| `rename_list` | Free | Rename a list |
| `ping` | Free | Connectivity check |
| `find_email` | 1 per email found | Verified work email for a name and company |
| `find_email_bulk` | 1 per email found | Same, up to 250 people per call |
| `email_verifier_verify` | 1 per email | Valid, invalid, catch-all or unknown |
| `email_verifier_verify_bulk` | 1 per email | Same, up to 250 emails per call |
| `lookup_phone` | 5 per person phone found | Mobile, direct and company numbers; 1 when only company numbers, 0 when none |
| `lookup_phones` | 5 per person phone found | Same, up to 50 people per call |
| `enrich_company` | 1 to 5 per category | Deep company data in 12 categories, charged once per company and category |
| `enrich_companies` | 1 to 5 per category | Same, up to 20 companies, all or nothing |
| `create_list` | Free | Create an empty list, or one with leads |
| `add_leads_to_list` | Credits only for leads saved without an email | Save people to a list |
| `delete_list` | Free | Delete a list and its leads; irreversible, always asks for confirmation |
| `delete_leads` | Free | Remove leads from a list; irreversible, always asks for confirmation |

Enrichment categories and cost: firmographics 1, headcount 3, financials 3, hiring 3, funding 2, technographics 2, acquisitions 2, competitors 1, social 1, traffic 1, contacts 1, signals 5.

### Prompts and resources

Prompts are ready-made workflows picked from the client menu: `find_decision_makers`, `enrich_and_save_list` and `verify_email_list`.

Resources are read-only documents a client can load into context: `skrapp://account/credits`, `skrapp://pricing/tool-costs`, `skrapp://reference/enrichment-categories` and `skrapp://reference/search-filters`.

Claude, Claude Code, Cursor and VS Code show prompts and resources; ChatGPT uses tools only.

## Safety model and limits

- **Quote before spend.** Company enrichment, phone lookups, list saves that trigger finder lookups and every delete first return `status: "confirmation_required"` with the exact cost and a `confirmationToken`. They run only when called again with `confirm: true` and that token. Nothing is charged for a quote. Single email finds and verifications (1 credit each) run directly.
- **Refusals are never charged.** Insufficient credits, rate limits, an expired trial or an unknown record come back as structured errors (`insufficient_credits`, `rate_limited` with `retry_after_seconds`, `trial_expired`, `not_found`) that say the call was not charged.
- **Rate limits, per account.** 250 read calls per minute, 250 spend calls per minute (separate counter), 25 bulk calls per minute.
- **You stay in control.** Disconnect the connector in your assistant, or revoke access from your Skrapp account. Access tokens expire within an hour.

## Versioning

The server version is returned in the `initialize` response and shown on <https://skrapp.io/mcp>. Changes are recorded in [CHANGELOG.md](CHANGELOG.md), which follows [Keep a Changelog](https://keepachangelog.com) and [Semantic Versioning](https://semver.org). [`server.json`](server.json) is the [MCP Registry](https://registry.modelcontextprotocol.io) manifest and carries the same version.

## Support

- Help center: <https://support.skrapp.io/hc/en-us>
- Email: <support@skrapp.io>
- Bugs in the docs or examples: [open an issue](https://github.com/skrappio/skrapp-mcp/issues/new/choose)
- Security: see [SECURITY.md](SECURITY.md)

See also [SUPPORT.md](SUPPORT.md).

## Privacy and terms

- Privacy policy: <https://skrapp.io/privacy>
- Terms of service: <https://skrapp.io/terms>

## License

The documentation, examples and manifest in this repository are released under the [MIT License](LICENSE). The hosted Skrapp MCP service, the Skrapp name and logo, and the Skrapp data are proprietary and governed by the [terms of service](https://skrapp.io/terms).
