# Ragnarok Remote Client

A lightweight HTTP server for Ragnarok Online client assets, built with [Vapor](https://vapor.codes) and Swift. It serves files from a client directory and extracts resources from `data.grf` on demand.

## Deploy a prebuilt image

The [Docker Hub image](https://hub.docker.com/r/arkadeleon/ragnarok-remote-client) includes game resources and is ready to run.

### Render

[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy?repo=https%3A%2F%2Fgithub.com%2Farkadeleon%2Fragnarok-remote-client)

Click **Deploy to Render**, sign in, and approve the Blueprint deployment. The template uses the prebuilt [`arkadeleon/ragnarok-remote-client:latest`](https://hub.docker.com/r/arkadeleon/ragnarok-remote-client) image, which already includes game resources. No local files, Docker installation, or volume mounts are required.

After the service is live, use its public URL with `/client` appended as the base URL for requesting game resources:

```text
https://your-service.onrender.com/client
```

The template selects Render's **Free** instance and port **8080**, matching the image's default listener. Free instances have 512 MB RAM and sleep after 15 minutes without traffic; waking takes about a minute, so the first resource request may time out. Wait for the service to wake and retry. See [Render's free instance limits](https://render.com/docs/free) for current usage limits.

### Docker

With Docker installed, start the server:

```bash
docker run -d --name ragnarok-remote-client --restart unless-stopped -p 8080:8080 arkadeleon/ragnarok-remote-client:latest
```

The resource base URL is `http://localhost:8080/client`. From another device, replace `localhost` with the host computer's LAN IP address.

To stop or restart the container:

```bash
docker stop ragnarok-remote-client
docker start ragnarok-remote-client
```

## Run from source

Clone the repository and enter its directory:

```bash
git clone https://github.com/arkadeleon/ragnarok-remote-client.git
cd ragnarok-remote-client
```

### Prepare resources

Place your client resources in the repository's `Resources/` directory:

```text
Resources/
├── BGM/
│   ├── 01.mp3
│   └── ...
└── data.grf
```

### Run with Swift

Requires **Swift 6.0+**.

```bash
swift run
```

### Build and run with Docker Compose

Requires **Docker with Compose**. The build copies your `Resources/` directory into the image.

```bash
docker compose up --build -d app
```

To stop the service:

```bash
docker compose down
```

Both methods listen on port **8080**. The local resource base URL is `http://localhost:8080/client`.

## API

Request resources using `GET /client/<path>`. The server first checks for a file under `Resources/`, then looks inside `data.grf`. Missing resources return **404 Not Found**.

| Request | Resource |
|---------|----------|
| `GET /client/BGM/01.mp3` | Background music |
| `GET /client/data/texture/À¯ÀúÀÎÅÍÆäÀÌ½º/bgi_temp.bmp` | Texture from the client data |

Percent-encode resource paths when constructing request URLs.

## License

[GPL-3.0](LICENSE)
