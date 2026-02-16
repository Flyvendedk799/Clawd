# OpenClaw deployment for Railway – uses official coollabsio image
FROM coollabsio/openclaw:latest

# Fix: coollabsio image expects a "browser" sidecar (proxy to browser:3000).
# On Railway we only run openclaw – no browser. Nginx fails with "host not found"
# unless "browser" resolves. Point it to localhost so nginx can start.
# /browser/ will 502, but the main OpenClaw UI works.
RUN echo "127.0.0.1 browser" >> /etc/hosts

# Copy custom config (non-secret settings; API keys/tokens go in env vars)
COPY config/openclaw.json /app/config/openclaw.json
ENV OPENCLAW_CUSTOM_CONFIG=/app/config/openclaw.json

# Railway sets PORT automatically – nginx listens on it
# Persistent data is at /data (mount Railway volume there)
# Trigger: 2026-02-16
