# CrossPoint Sync

KOSync-compatible sync server for CrossPoint / CrossInk e-readers and KOReader.
Packages https://github.com/crosspoint-reader/crosspoint-sync.

## Setup

1. Start the app.
2. Open the web UI at `http://<home-assistant>:8080/app/` and create an account
   (or create one from your reader's sync settings).
3. Configure your reader:
   - KOReader: Tools → Progress sync → Custom sync server → `http://<home-assistant>:8080`
   - CrossPoint / CrossInk: Settings → KOReader Sync → Sync Server URL

Host port 8080 must stay reachable from your readers. Home Assistant ingress is
not supported: it strips the URL prefix, while CrossPoint Sync expects a proxy that
preserves it, and e-readers cannot authenticate with a Home Assistant session.

## Options

| Option | Meaning |
| --- | --- |
| `token_enc_key` | 64 hex chars from `openssl rand -hex 32`. Required to save credentials for external services. Changing it makes saved logins unreadable. |
| `registration_disabled` | Refuse new account creation. |
| `trust_proxy` | Trust `X-Forwarded-Proto` from a real TLS reverse proxy. |
| `allow_http_localhost` | Allow credential entry over HTTP at `localhost` only. |
| `https_hack` | See below. Default off. |

## The `https_hack` option

Credential saving normally requires HTTPS. Some connectors cannot be linked over
plain HTTP until this is enabled.

When on, nginx tells the app that requests to `/api/v1/connectors` arrived over
HTTPS. Nothing is actually encrypted.

Risks:
- Credentials and tokens still cross your network in cleartext.
- The server cannot tell a man-in-the-middle from you.
- OAuth connectors that redirect back still fail, because the callback URL has no
  real TLS.
- Any device on your LAN can write credentials while the option is on.

Turn it on only long enough to link services, then turn it off and restart.
The better alternative is a TLS reverse proxy in front of the app, with
`trust_proxy` enabled.

## Data and backups

The SQLite database is at `/data/crosspoint.db` inside the app, stored on the host
under the app's private data folder. It is included in Home Assistant backups when
this app is selected. Backups are taken "cold" — the app is stopped briefly.

## Licence

Packaging: MIT. Upstream CrossPoint Sync: MIT.
Not affiliated with or endorsed by the CrossPoint project.
