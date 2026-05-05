# Docker And PostgreSQL Notes

## Docker Permission Denied

If Docker is installed but commands fail with permission errors:

```bash
sudo systemctl enable --now docker
sudo usermod -aG docker "$USER"
```

Log out and back in after adding the group.

Check:

```bash
docker info
```

## Compose

Arch package:

```text
docker-compose
```

Basic check:

```bash
docker-compose version
```

## PostgreSQL Port 5432 Busy

Find what is using the port:

```bash
ss -ltnp | grep ':5432'
```

Common causes:

- local PostgreSQL service already running;
- Docker container exposing `5432`;
- previous dev container still alive.

Inspect containers:

```bash
docker ps
```

Stop a specific container only after confirming it:

```bash
docker stop <container>
```

Do not run broad prune commands as part of this dotfiles workflow.

