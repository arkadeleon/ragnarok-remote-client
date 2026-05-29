# Ragnarok Remote Client

A lightweight HTTP server that serves Ragnarok Online client assets — GRF-packed files and BGM — over the network. Built with [Vapor](https://vapor.codes) and Swift.

Any HTTP client can request game resources at `/client/<path>`. The server first looks for the file on disk under `Resources/`, then falls back to extracting it from `data.grf`.

## Prerequisites

- **Swift 6.0+** (for the native run), or
- **Docker** (no Swift installation required)

## Setup

Before running the server, place your game assets in the `Resources/` folder:

```
Resources/
├── BGM/          ← copy your entire BGM folder here
│   ├── 01.mp3
│   ├── 02.mp3
│   └── ...
└── data.grf      ← copy your data.grf file here
```

> Both `BGM/` and `data.grf` are required. The server returns `404` for any path not found in either location.

## Running

### Option 1 — Swift (native)

```bash
swift run
```

The server starts on **http://localhost:8080**.

### Option 2 — Docker

```bash
docker compose up app
```

The server starts on **http://localhost:8080**.

To stop it:

```bash
docker compose down
```

## API

All assets are served under the `/client/` prefix.

| Method | Path | Description |
|--------|------|-------------|
| `GET` | `/client/<path>` | Serve a file from `Resources/` or `data.grf` |

**Examples:**

```
GET /client/BGM/01.mp3
GET /client/data/texture/À¯ÀúÀÎÅÍÆäÀÌ½º/bgi_temp.bmp
```

## License

[GPL-3.0](LICENSE)
