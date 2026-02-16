# OpenClaw deployment for Railway – uses official coollabsio image
FROM coollabsio/openclaw:latest

# Copy custom config (non-secret settings; API keys/tokens go in env vars)
COPY config/openclaw.json /app/config/openclaw.json
ENV OPENCLAW_CUSTOM_CONFIG=/app/config/openclaw.json

# Fix: nginx expects "browser" host; Railway has no sidecar. Add at RUNTIME
# (build-time /etc/hosts gets overwritten by container runtime).
COPY scripts/entrypoint-wrapper.sh /app/scripts/entrypoint-wrapper.sh
RUN chmod +x /app/scripts/entrypoint-wrapper.sh
ENTRYPOINT ["/app/scripts/entrypoint-wrapper.sh"]

# Railway sets PORT automatically – nginx listens on it
# Persistent data is at /data (mount Railway volume there)
# v2
