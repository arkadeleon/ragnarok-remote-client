# Ragnarok Remote Client

A lightweight HTTP server for Ragnarok Online client assets, built with [Vapor](https://vapor.codes) and Swift. It serves files from a client directory and extracts resources from `data.grf` on demand.

## Deploy a prebuilt image

The [Docker Hub image](https://hub.docker.com/r/arkadeleon/ragnarok-remote-client) includes game resources and is ready to run.

### Railway

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/deploy/ragnarok-remote-client?referralCode=wKbXec&utm_medium=integration&utm_source=template&utm_campaign=generic)

Click **Deploy on Railway**, sign in, and deploy the template. It uses the prebuilt Docker Hub image, so no local files, Docker installation, or volume mounts are required.

After the service is live, use its public URL as the base URL for requesting game resources. If no public domain is configured, generate one targeting port **8080** in the service's networking settings:

```text
https://your-service.up.railway.app
```

Choose a Railway plan that supports Docker images larger than **4 GB**. Hosting and network usage charges apply; see [Railway pricing](https://railway.com/pricing).

Deploying through this template helps support the project through Railway's template kickback program. The deployment link also includes the maintainer's referral code.

### Docker

With Docker installed, start the server:

```bash
docker run -d --name ragnarok-remote-client --restart unless-stopped -p 8080:8080 arkadeleon/ragnarok-remote-client:latest
```

The resource base URL is `http://localhost:8080`. From another device, replace `localhost` with the host computer's LAN IP address.

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

Both methods listen on port **8080**. The local resource base URL is `http://localhost:8080`.

## API

Request resources using `GET /<path>`. The server first checks for a file under `Resources/`, then looks inside `data.grf`. Missing resources return **404 Not Found**.

| Request | Resource |
|---------|----------|
| `GET /BGM/01.mp3` | Background music |
| `GET /data/texture/À¯ÀúÀÎÅÍÆäÀÌ½º/bgi_temp.bmp` | Texture from the client data |

Percent-encode resource paths when constructing request URLs.

## License

[GPL-3.0](LICENSE)
