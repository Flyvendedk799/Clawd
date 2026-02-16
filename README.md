# OpenClaw – Railway Deployment

OpenClaw setup configured for **24/7 deployment on Railway**, with your local settings (Anthropic models, Telegram, WhatsApp, web search, hooks) applied. Secrets stay in environment variables.

## Quick start – Railway

1. **Push to GitHub**
   ```bash
   git init
   git add .
   git commit -m "Initial OpenClaw deployment"
   git branch -M main
   git remote add origin https://github.com/YOUR_USERNAME/claw.git
   git push -u origin main
   ```

2. **Connect Railway**
   - Go to [railway.app](https://railway.app) → New Project
   - Choose **Deploy from GitHub repo**
   - Select your `claw` repo
   - Railway will detect the Dockerfile and build automatically

3. **Add persistent volume**
   - In your Railway service → **Volumes** → **Add Volume**
   - Mount path: `/data`
   - This keeps state, sessions, and workspace across restarts

4. **Set environment variables**
   - Service → **Variables** → **Add variables**
   - Use the values from `.env.example` (see below)
   - **Required:** `ANTHROPIC_API_KEY`, `AUTH_PASSWORD`, `OPENCLAW_GATEWAY_TOKEN`
   - **Optional:** `BRAVE_API_KEY`, `TELEGRAM_BOT_TOKEN`, `TELEGRAM_ALLOW_FROM`, `WHATSAPP_ALLOW_FROM`, etc.

5. **Generate domain**
   - Service → **Settings** → **Networking** → **Generate domain**
   - Your OpenClaw UI will be at `https://your-app.up.railway.app`

## Environment variables (copy from your local setup)

| Variable | Your value | Notes |
|----------|------------|-------|
| `ANTHROPIC_API_KEY` | *(your key)* | Required |
| `AUTH_PASSWORD` | *(choose strong password)* | Protects web UI |
| `OPENCLAW_GATEWAY_TOKEN` | *(generate new or reuse)* | For Cursor/Claude Code/API |
| `BRAVE_API_KEY` | *(your Brave Search key)* | Web search (optional) |
| `TELEGRAM_BOT_TOKEN` | *(your bot token)* | From BotFather |
| `TELEGRAM_ALLOW_FROM` | `8312856457` | Your user ID |
| `WHATSAPP_ALLOW_FROM` | `+4523822482` | E.164 format |

Generate a new `OPENCLAW_GATEWAY_TOKEN` for production (e.g. `openssl rand -hex 32`).

## Local development

```bash
cp .env.example .env
# Edit .env and add your keys
docker compose up -d
```

OpenClaw UI: http://localhost:8080 (login: admin / your `AUTH_PASSWORD`)

## Project structure

```
claw/
├── config/
│   └── openclaw.json   # Non-secret settings (models, agents, channels structure)
├── Dockerfile          # Builds from coollabsio/openclaw + your config
├── docker-compose.yml  # Local development
├── railway.json        # Railway build/deploy config
├── .env.example        # Template for required env vars
├── .gitignore
└── README.md
```

## Notes

- **Browser tool:** The browser sidecar (CDP for web automation) is not included in this deployment. Web search works via Brave API. To add a browser, you’d need an additional Railway service.
- **WhatsApp:** After first deploy, use the web UI or logs to complete QR pairing. Credentials will be stored in the `/data` volume.
- **Telegram:** Works out of the box with your bot token and allowlist.
