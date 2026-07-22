# ood-demo
A container for demonstrating OpenOnDemand

## Getting started

Pull this repository down and issue `rake build` to build the container.
Or pull it from dockerhub at `openondemand/open-ondemand-demo:latest`.

## Starting the container

If you'd like to build and start the container, the rake task `rake start`.

If you'd like to pull the image off of dockerhub, pull the image and start it with
these commands.

Note that it's important to start on port `8080` as that's what the container expects.
It relies on `localhost` so running through over the network will require additional work.

In addition, starting it with the hostname `ood.demo` (`-h ood.demo`) is important
for proxying and shell access as both rely on allowlists which have been preconfigured.

```
docker pull openondemand/open-ondemand-demo:latest
docker run --rm -p 8080:8080 -h ood.demo openondemand/open-ondemand-demo:latest
```
or 
```
podman pull docker.io/openondemand/open-ondemand-demo:latest
podman run --rm -p 8080:8080 -h ood.demo --privileged docker.io/openondemand/open-ondemand-demo:latest
```

## Logging in

Once the container is started, it will be accessible at `http://localhost:8080`.

A user has already been created, simply login as `jesse@localhost` with the password `owens`.
