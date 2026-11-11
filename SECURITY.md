# Security policy

## Reporting a vulnerability

Do not open a public issue, pull request or discussion for a security problem. Email <security@skrapp.io> with the subject "Security: Skrapp MCP" and include:

- what you found and the impact you expect,
- steps to reproduce, with the client, tool and approximate time (UTC),
- any request ID from the response, with tokens, API keys and personal data removed.

We acknowledge reports as soon as we can and keep you informed until the issue is resolved. Please give us reasonable time to fix a problem before disclosing it.

## Scope

In scope:

- the hosted server at `https://mcp.skrapp.io/` and its OAuth endpoints (`/oauth/*`, `/.well-known/*`),
- the authorization flow on `https://app.skrapp.io/oauth/authorize`,
- the content of this repository (for example an example config that leaks a secret).

Out of scope:

- denial-of-service, load or volumetric testing, and spam,
- social engineering of Skrapp staff or users,
- findings that need a compromised client device,
- third-party clients and assistants (report those to their vendor),

Test only with your own Skrapp account and credits. Never access, modify or retain another user's data.

This repository contains no service source code and no secrets. If you find a credential here, report it as above.
