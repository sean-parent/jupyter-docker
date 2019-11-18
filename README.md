## Build Image
_install docker_


```
docker run -t -i ubuntu:latest

docker image build -t notebook:1.0 .
docker image build -t docs-tool-cpp-base:1.0.0 .

docker image build --no-cache -t docs-tool-cpp-base:1.0.0 .

https://github.com/sean-parent/jupyter-docker/packages?package_type=Docker

docker image build -t docker.pkg.github.com/sean-parent/jupyter-docker/docs-tool-cpp-base:1.0.1 .
docker push docker.pkg.github.com/sean-parent/jupyter-docker/docs-tool-cpp-base:1.0.0
docker tag a26d55c04a35 docker.pkg.github.com/sean-parent/jupyter-docker/docs-tool-cpp-base:1.0.0


docker build -t docker.pkg.github.com/sean-parent/jupyter-docker/docs-tool-cpp-base:1.1.0 .

docker run -t -i docker.pkg.github.com/sean-parent/jupyter-docker/docs-tool-cpp-base:1.1.0


```
docker container run -t -i docs-tool-cpp-base:1.0.0 bash


docker container run --mount type=bind,source="$(pwd)",target=/mnt/docs-src  -t -i -p 3000:3000 -p 3001:3001 -p 8888:8888 notebook:1.0  bash


1.15GB
