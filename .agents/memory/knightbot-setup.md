---
name: Knightbot-MD setup quirks
description: Key issues when setting up Knight Bot in Replit — blocked packages, Node version, ESM baileys, sharp rebuild
---

## Node.js version
Baileys v7 requires Node.js 20+. The repo has `nodejs-18` in `.replit` but must be upgraded to `nodejs-20`.
**Why:** `@whiskeysockets/baileys` v7 has `engine-requirements.js` that exits if Node < 20, and uses `globalThis.crypto` unavailable in Node 18 global scope.
**How to apply:** Use `installProgrammingLanguage({ language: "nodejs-20" })` before any other setup.

## Blocked packages (Replit security policy)
`form-data@2.3.3` is blocked (Critical CVE) at `package-firewall.replit.local`. This cascades to block:
- `request@2.88.2` → `form-data@~2.3.2`
- `gtts@0.2.1` → `request@^2.67.0`
**How to apply:** Create stub modules. Stubs get wiped by `npm install`, so `start.sh` recreates them on boot.

## Startup script
`start.sh` is required instead of `node index.js` directly:
1. Recreates `gtts` stub if wiped by npm
2. Recreates `supports-color` stub if wiped
3. Rebuilds `sharp` native module if missing after Node upgrade
4. Then runs `node index.js`

## sharp native module
After upgrading Node.js version, run `npm rebuild sharp`. The `start.sh` handles this automatically.

## undici version
`@distube/ytdl-core` requires `undici@^7.8.0`. Installed `undici@7` separately.

## Deployment
Configured as `vm` type (always-running bot). Run command: `bash start.sh`
