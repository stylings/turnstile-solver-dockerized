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
```
