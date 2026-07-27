# ood-demo
A container for demonstrating OpenOnDemand

## Getting started

Pull this repository down and issue `rake build` to build the container.
Or pull it from dockerhub at `openondemand/open-ondemand-demo:latest`.

The published image is multi-arch (`linux/amd64` and `linux/arm64`), so it runs
natively on both Intel/AMD machines and Apple Silicon Macs.

## Starting the container

If you'd like to build and start the container, use the rake task `rake start`.

If you'd like to pull the image off of dockerhub, pull the image and start it with
these commands.

Note that it's important to start on port `8080` as that's what the container expects.
It relies on `localhost` so running it over the network will require additional work.

In addition, starting it with the hostname `ood.demo` (`-h ood.demo`) is important
for proxying and shell access as both rely on allowlists which have been preconfigured.

The `--privileged` flag is required because the container boots systemd as PID 1.
Without it, Docker starts the container but no services (and no web portal) ever
come up.

```
docker pull openondemand/open-ondemand-demo:latest
docker run --rm --privileged -p 8080:8080 -h ood.demo openondemand/open-ondemand-demo:latest
```
or
```
podman pull docker.io/openondemand/open-ondemand-demo:latest
podman run --rm --privileged -p 8080:8080 -h ood.demo docker.io/openondemand/open-ondemand-demo:latest
```

## Mac Users

If you are using a mac you will need to pull this different image and build.
```shell
docker pull travertosc/ood-demo:latest
docker run --rm --privileged -p 8080:8080 -h ood.demo openondemand/open-ondemand-demo:latest
```

## Logging in

Once the container is started, it will be accessible at `http://localhost:8080`.

A user has already been created, simply login as `jesse@localhost` with the password `owens`.

## Troubleshooting

**The terminal shows nothing after `docker run`.** This is expected. The container
boots systemd, which logs to its own journal rather than the container's stdout,
so a foreground run appears silent even when everything is working. Give it
about 30 seconds after starting before opening the browser. Do not press
`Ctrl-C` — systemd treats that as a shutdown signal and, combined with `--rm`,
the container will stop and be removed.

**"Unable to connect" in the browser right after starting.** The first boot has
to generate the portal and Dex configuration before Apache starts listening.
Wait roughly 30 seconds and reload.

**"Bad Request" after logging in.** Your browser is holding OIDC cookies from a
previous run of the container that no longer validate. Clear cookies for
`localhost` (or use a private/incognito window) and log in again. This is most
common with images built before the fixed `oidc_crypto_passphrase` was added
(#31), where every container start regenerated the OIDC secrets.

**Port 8080 is already in use.** Another application (commonly a Jupyter server
or a development web server) is already bound to 8080. Stop it and start the
container again. The container must be published on host port 8080 — the portal
is configured for `localhost:8080` and other host ports will not work without
additional configuration.

**Shell or interactive apps fail but the dashboard works.** You most likely
started the container without `-h ood.demo`. The shell and proxy allowlists are
preconfigured for that hostname, so it is required.

To check on the services inside a running container:

```
docker exec <container-name> systemctl --failed
docker exec <container-name> journalctl -u httpd -u ondemand-dex --no-pager
```

(Substitute `podman` for `docker` as appropriate.)
