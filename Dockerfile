# OpenClaw deployment for Railway – uses official coollabsio image
FROM coollabsio/openclaw:latest

# Copy custom config (non-secret settings; API keys/tokens go in env vars)
COPY config/openclaw.json /app/config/openclaw.json
ENV OPENCLAW_CUSTOM_CONFIG=/app/config/openclaw.json

# Railway sets PORT automatically – nginx listens on it
# Persistent data is at /data (mount Railway volume there)
