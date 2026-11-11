# Home Assistant app: CrossPoint Sync

[![Open your Home Assistant instance and show the add app repository dialog with a specific repository URL pre-filled.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2FIngoHenning%2Fhomeassistant_crosspoint_sync)

A Home Assistant app that packages [CrossPoint Sync](https://github.com/crosspoint-reader/crosspoint-sync)
— a lightweight, KOSync-compatible sync server for CrossPoint / CrossInk e-readers and KOReader.

## Install

1. Click the badge above, or add
   `https://github.com/IngoHenning/homeassistant_crosspoint_sync` under
   **Settings → Apps → Install app → ⋮ → Repositories**.
2. Install **CrossPoint Sync** and start it.
2. Open `http://<your-home-assistant>:8080/app/` and create an account.
3. Point your reader at `http://<your-home-assistant>:8080`:
   - **KOReader:** Tools → Progress sync → Custom sync server
   - **CrossPoint / CrossInk:** Settings → KOReader Sync → Sync Server URL

## Notes

- The app serves on host port **8080**. E-readers talk the KOSync protocol directly to that
  port, so it cannot be hidden behind Home Assistant ingress.
- Data lives in the app's private `/data` folder (`crosspoint.db`) and is included in
  Home Assistant backups when the app is selected.
- `TOKEN_ENC_KEY` enables linking external services (Hardcover, Micro.blog, Readwise,
  BookFusion, Jellyfin, Audiobookshelf…). Set it once; changing it later invalidates
  saved service logins.

## Licence

The packaging in this repository is MIT licensed. CrossPoint Sync itself is MIT licensed
by its authors — see `crosspoint_sync/THIRD-PARTY-NOTICES.md`. This app is not affiliated
with or endorsed by the CrossPoint project.
