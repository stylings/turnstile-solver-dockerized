FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

RUN apt-get update && apt-get install -y --no-install-recommends \
    libgtk-3-0 libasound2 libdbus-glib-1-2 libx11-xcb1 \
    libxcomposite1 libxdamage1 libxrandr2 libpango-1.0-0 \
    libcairo2 libatk1.0-0 libatk-bridge2.0-0 libcups2 libdrm2 \
    xvfb \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

RUN useradd --create-home --uid 10001 app
USER app

# Keep only assets needed for Linux fingerprints.
RUN python -m camoufox fetch \
    && rm -rf /home/app/.cache/camoufox/fonts/macos \
              /home/app/.cache/camoufox/fonts/windows \
              /home/app/.cache/camoufox/fontconfigs/macos \
              /home/app/.cache/camoufox/fontconfigs/windows

COPY --chown=app:app api_solver.py .

EXPOSE 5000

HEALTHCHECK --interval=30s --timeout=5s --start-period=30s --retries=3 \
    CMD ["python", "-c", "import urllib.request; urllib.request.urlopen('http://localhost:5000/health', timeout=3)"]

CMD ["python", "api_solver.py", "--headless", "virtual", "--host", "0.0.0.0", "--port", "5000"]
