# Changelog

## 1.0.5

- Updated third party notices
- Updated documentation

## 1.0.4

- AppArmor profile (`apparmor.txt`) now enforcing, not complain.
- Container runs with a restrictive profile: only `/data` is writable state,
  outbound file access limited to CA certificates.

## 1.0.2

- Set AppArmor to enforce

## 1.0.1

- Added AppArmor

## 1.0.0

- First public release. Packages CrossPoint Sync **0.1.0** (upstream commit cf86947).
- Packages CrossPoint Sync behind nginx on port 8080; Node listens on 127.0.0.1:8081.
- Options: `token_enc_key`, `registration_disabled`, `trust_proxy`,
  `allow_http_localhost`, `https_hack`.
- `https_hack` is **off by default**. It was implicitly enabled in earlier local
  builds by a hardcoded nginx directive; enabling it is now an explicit opt-in.
  Existing connector links keep working with it off — only new credential writes
  are gated.
