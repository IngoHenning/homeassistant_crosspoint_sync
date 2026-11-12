# CrossPoint Sync

KOSync-compatible progress-sync server for CrossPoint / CrossInk e-readers and
KOReader. This app packages
[CrossPoint Sync](https://github.com/crosspoint-reader/crosspoint-sync) for
Home Assistant.

## Setup

1. Start the app.
2. Open the web UI at `http://<home-assistant>:8080/app/` and create an account
   (you can also create one from your reader's sync settings).
3. Configure your reader:
   - **KOReader:** Tools → Progress sync → Custom sync server → `http://<home-assistant>:8080`
   - **CrossPoint / CrossInk:** Settings → KOReader Sync → Sync Server URL

Host port **8080** must stay reachable from your readers. Home Assistant ingress
is not supported: it strips the URL prefix, while CrossPoint Sync expects a proxy
that preserves it, and e-readers cannot authenticate with a Home Assistant
session.

## Options

| Option | Default | Meaning |
| --- | --- | --- |
| `token_enc_key` | *(empty)* | 64 hex characters from `openssl rand -hex 32`. Required to save credentials for external services. Changing it makes previously saved service logins unreadable. |
| `registration_disabled` | off | Refuse new account creation. Turn on once your devices have accounts. |
| `trust_proxy` | off | Trust `X-Forwarded-Proto` from a real TLS reverse proxy in front of this app. |
| `allow_http_localhost` | off | Allow credential entry over plain HTTP when the app is reached via `localhost` only. |
| `https_hack` | off | See below. |

## The `https_hack` option

Saving credentials for external services normally requires HTTPS. Some
connectors cannot be linked over plain HTTP until this is enabled.

When on, nginx tells the app that requests to `/api/v1/connectors` arrived over
HTTPS. **Nothing is actually encrypted.** The signal is forged, not earned.

Risks:

- Credentials and tokens still cross your network in cleartext.
- The server cannot distinguish a man-in-the-middle from you.
- OAuth connectors that redirect back still fail, because the callback URL has
  no real TLS.
- Any device on your LAN can write credentials while the option is on.

Turn it on only long enough to link services, then turn it off and restart the
app. The better alternative is a TLS reverse proxy in front of the app, with
`trust_proxy` enabled.

## Data and backups

Your reading progress and accounts are stored in a database in the app's private
data folder. It is included in Home Assistant backups when this app is selected.
Backups are taken **cold** — the app is stopped briefly.

You don't need to manage this folder yourself, and you can't browse it over
Samba. Uninstalling the app deletes it, so take a backup before removing the app.

## Security

For your protection, the app is confined to its own data folder and cannot modify anything else on your Home Assistant system.

## Troubleshooting

| Symptom | Likely cause |
| --- | --- |
| Web UI does not load on port 8080 | Port 8080 is already used by another service on the host. Change the host port in the app's network settings. |
| Reader cannot reach the server | Reader is on a different network/VLAN than Home Assistant, or the host port is not exposed. |
| Connector credentials will not save | No `token_enc_key` set, or you are on plain HTTP without `https_hack`. See the option above. |
| Saved service logins stopped working | `token_enc_key` was changed. Re-link the services. |
| App starts but the UI shows errors | Check the app log for the details. |

## Licence

The packaging in this app is MIT licensed. CrossPoint Sync itself is MIT
licensed by its authors. Bundled web fonts are licensed under the SIL Open Font
License 1.1. Full texts are in `THIRD-PARTY-NOTICES.md`.

This app is not affiliated with or endorsed by the CrossPoint project.

Service names and logos shown in the app — including KOSync, Hardcover,
Micro.blog, Readwise, BookFusion, Jellyfin and Audiobookshelf — are trademarks of
their respective owners, used only to identify the service being configured.
