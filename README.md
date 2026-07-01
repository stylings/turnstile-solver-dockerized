# turnstile-solver-dockerized

One-command Cloudflare Turnstile solver using camoufox (headless). Forked from [Theyka/Turnstile-Solver](https://github.com/Theyka/Turnstile-Solver).

## Usage

```bash
docker run -d -p 5000:5000 ghcr.io/stylings/turnstile-solver-dockerized
```

Or with Docker Compose:

```bash
docker compose up -d
```

[Published images](https://github.com/stylings/turnstile-solver-dockerized/pkgs/container/turnstile-solver-dockerized)

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

**Health check:**

```
GET /health
```

→ `{"status": "ok"}`

## CLI args

Override in `docker-compose.yml` CMD or `Dockerfile`:

| Arg          | Default   | Description                                    |
| ------------ | --------- | ---------------------------------------------- |
| `--headless` | `virtual` | `true`, `false`, or `virtual` (Xvfb; recommended for headless servers, `true` gets detected by Turnstile) |
| `--thread`   | `1`       | Parallel browser instances                     |
| `--debug`    | `False`   | Verbose solve logs                             |
| `--host`     | `0.0.0.0` | Bind address                                   |
| `--port`     | `5000`    | Listen port                                    |
| `--proxy`    | `False`   | Load proxies from `proxies.txt`                |
