# multiarch-example

This project demonstrates how to use the experimental docker build engine
*buildx* in hub to build multiarch containers.

## Steps

### Build manually

```bash
export DOCKER_CLI_EXPERIMENTAL=enabled
docker run --rm --privileged docker/binfmt:820fdd95a9972a5308930a2bdfb8573dd4447ad3
docker buildx create --use --name multiarch
docker buildx build --tag 1nfiniteloop/multiarch-example --platform=linux/arm,linux/arm64,linux/amd64 .
```

### Inspect

docker buildx imagetools inspect 1nfiniteloop/multiarch-example

## Reference

* docker buildx - <https://www.docker.com/blog/getting-started-with-docker-for-arm-on-linux/>
* Docker hub hooks - <https://docs.docker.com/docker-hub/builds/advanced/>
