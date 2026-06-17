# Knight Bot (Knightbot-MD)

A multi-device WhatsApp automation bot built using the Baileys library. Designed for group management, entertainment, and utility automation on WhatsApp.

## Features

- **Group Management**: Auto-kick, promotion/demotion, muting, tagging all members
- **Moderation**: Anti-link, anti-badword, anti-call, anti-delete
- **Utility**: Sticker creation, YouTube downloading, language translation, TTS
- **Entertainment**: AI chat, Tic-Tac-Toe, Hangman, Trivia, meme generators

## Setup

1. Start the bot — it will display a pairing code
2. Open WhatsApp on your phone
3. Go to Settings > Linked Devices > Link a Device
4. Enter the pairing code shown in the console

## Configuration

Edit `settings.js` to configure:
- `ownerNumber`: Your WhatsApp number (with country code, no +)
- `botName`: The bot's display name
- `commandMode`: "public" or "private"

Edit `config.js` to configure API keys for external services.

## Architecture

- `index.js` — Main entry point, WhatsApp connection & auth
- `main.js` — Message handler and command router
- `commands/` — Individual command modules
- `lib/` — Utility/helper functions
- `data/` — JSON persistence files
- `session/` — WhatsApp auth credentials

## Runtime Notes

- Node.js 20+ required (Baileys v7 dependency)
- `gtts` package is stubbed (blocked by security policy; TTS commands return an error)
- `sharp` native module is rebuilt at startup if needed
- The `start.sh` script ensures all stub modules are in place before launch

## User Preferences

- Keep changes minimal and follow existing project structure
