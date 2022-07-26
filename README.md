# multiarch-example

This project demonstrates how to use the new docker build engine _buildx_ in
GitHub actions to build and publish multiarch containers. Running
this jobs in docker-hub turned out to be challenging.

## Steps

Setup binfmt_misc on host:

    sudo apt install qemu-user-static

### Build and export locally

    $ docker buildx build \
        --tag 1nfiniteloop/multiarch-example \
        --platform=linux/arm,linux/arm64,linux/amd64 \
        --load \
        .
    [+] Building 0.0s (0/0)
    error: docker exporter does not currently support exporting manifest lists

As seen above it's not possible to have one image with multiple architectures
locally. Thus, each platform must be built and exported separately (and tagged
differently to not be overridden).

    $ docker buildx build \
        --load \
        --tag 1nfiniteloop/multiarch-example \
        --platform=linux/arm \
        .

Run image:

    docker run --platform linux/arm/v7 --rm 1nfiniteloop/multiarch-example

### Build and publish to registry

Build multiarch images and push to registry:

    docker buildx create --use --name multiarch
    docker buildx build \
      --tag 1nfiniteloop/multiarch-example \
      --platform=linux/arm,linux/arm64,linux/amd64 \
      --push \
      .

Fetch image from registry for one architecture and run:

    docker run --platform linux/arm64 1nfiniteloop/multiarch-example

    # this will override local image "1nfiniteloop/multiarch-example:latest" with
    # a new architecture:
    docker run --platform linux/arm/v7 1nfiniteloop/multiarch-example

Fetch image from registry for multiple architectures:

    # inspect images available on the registry:
    docker buildx imagetools inspect 1nfiniteloop/multiarch-example

    docker run --platform linux/arm/v7 \
      docker.io/1nfiniteloop/multiarch-example:latest@sha256:1d0a070e0b338afe9cac708e7bb134480d51d6e389db3b483008d87f48538e81

    docker run --platform linux/arm64 \
      docker.io/1nfiniteloop/multiarch-example:latest@sha256:b50bf9895d3fd2870795a83610ce58d0ccd45b952efbe63eae205ecf155ae037

    $ docker images
    REPOSITORY                      TAG     IMAGE ID       CREATED      SIZE
    1nfiniteloop/multiarch-example  <none>  d1d64d744755   2 years ago  5.35MB
    1nfiniteloop/multiarch-example  <none>  46a62a53d787   2 years ago  3.81MB

## Reference

* Docker multi-arch <https://docs.docker.com/desktop/multi-arch/>
* Buildx reference - <https://github.com/docker/buildx>
* Docker hub hooks - <https://docs.docker.com/docker-hub/builds/advanced/>
* Github actions - <https://help.github.com/en/actions/reference/>
