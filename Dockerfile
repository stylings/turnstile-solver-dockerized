FROM python:3.12-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl wget ca-certificates gnupg \
    libgtk-3-0 libasound2 libdbus-glib-1-2 libx11-xcb1 libxt6 \
    libxcomposite1 libxdamage1 libxrandr2 libpango-1.0-0 \
    libcairo2 libatk1.0-0 libatk-bridge2.0-0 libcups2 libdrm2 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# camoufox fetch is slow - cache it before app code changes
RUN pip install --no-cache-dir camoufox[geoip]
RUN python -m camoufox fetch
RUN pip install --no-cache-dir quart patchright

COPY api_solver.py .

EXPOSE 5000

CMD ["python", "api_solver.py", "--browser_type", "camoufox", "--headless", "True", "--host", "0.0.0.0", "--port", "5000", "--debug", "True"]
