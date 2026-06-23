# turnstile-solver-dockerized

One-command Cloudflare Turnstile solver using camoufox (headless). Forked from [Theyka/Turnstile-Solver](https://github.com/Theyka/Turnstile-Solver).

## Usage

```bash
docker compose up -d --build
```

## API

**Request a solve:**
```
GET /turnstile?url=https://example.com&sitekey=0x4AAAAAAA...
```
→ `{"task_id": "uuid"}`

**Get the token:**
```
GET /result?id=uuid
```
→ `{"value": "0.xxx...", "elapsed_time": 3.2}`

## CLI args

Override in `docker-compose.yml` CMD or `Dockerfile`:

| Arg | Default | Description |
|-----|---------|-------------|
| `--browser_type` | `camoufox` | `chromium`, `chrome`, `msedge`, `camoufox` |
| `--headless` | `True` | Headless mode (camoufox handles its own UA) |
| `--thread` | `1` | Parallel browser instances |
| `--debug` | `False` | Verbose solve logs |
| `--host` | `0.0.0.0` | Bind address |
| `--port` | `5000` | Listen port |
| `--proxy` | `False` | Load proxies from `proxies.txt` |
