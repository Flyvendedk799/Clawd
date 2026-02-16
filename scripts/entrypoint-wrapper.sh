#!/bin/sh
# Fix: coollabsio nginx expects "browser" host (sidecar). On Railway we run solo.
# Add at runtime - /etc/hosts is often overwritten by container runtime at start.
grep -qxF '127.0.0.1 browser' /etc/hosts 2>/dev/null || echo '127.0.0.1 browser' >> /etc/hosts
exec /app/scripts/entrypoint.sh "$@"
