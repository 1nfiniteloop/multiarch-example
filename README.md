# multiarch-example

This project demonstrates how to use the experimental docker build engine
*buildx* in GitHub actions to build and publish multiarch containers. Running
this in docker-hub proved to be challenging.

## Steps

### Build manually

```bash
export DOCKER_CLI_EXPERIMENTAL=enabled
docker run --rm --privileged docker/binfmt:820fdd95a9972a5308930a2bdfb8573dd4447ad3
docker buildx create --use --name multiarch
docker buildx build --tag 1nfiniteloop/multiarch-example --platform=linux/arm,linux/arm64,linux/amd64 .
```

### Inspect

```bash
docker buildx imagetools inspect 1nfiniteloop/multiarch-example
```

## Reference

* Docker buildx blog - <https://www.docker.com/blog/getting-started-with-docker-for-arm-on-linux/>
* Buildx reference - <https://github.com/docker/buildx>
* Docker hub hooks - <https://docs.docker.com/docker-hub/builds/advanced/>
* Github actions - <https://help.github.com/en/actions/reference/>
