## Build Image
_install docker_


```
VERSION="1.2.1"
echo $VERSION > ./VERSION
docker build -t docker.pkg.github.com/sean-parent/jupyter-docker/docs-tool-cpp-base:latest .
docker tag docker.pkg.github.com/sean-parent/jupyter-docker/docs-tool-cpp-base:latest \
    docker.pkg.github.com/sean-parent/jupyter-docker/docs-tool-cpp-base:$VERSION
docker push docker.pkg.github.com/sean-parent/jupyter-docker/docs-tool-cpp-base:latest
docker push docker.pkg.github.com/sean-parent/jupyter-docker/docs-tool-cpp-base:$VERSION
```

```
docker run -t -i docker.pkg.github.com/sean-parent/jupyter-docker/docs-tool-cpp-base:latest

https://github.com/sean-parent/jupyter-docker/packages?package_type=Docker

```

docker run --mount type=bind,source="$(pwd)",target=/mnt/docs-src  -t -i -p 3000:3000 -p 3001:3001 -p 8888:8888 notebook:1.0  bash


1.15GB
