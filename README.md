## Build Image
_install docker_


```
docker run -t -i ubuntu:latest

docker image build -t notebook:1.0 .
```
docker container run -t -i notebook:1.0 bash


docker container run --mount type=bind,source="$(pwd)",target=/mnt/docs-src  -t -i -p 3000:3000 -p 3001:3001 -p 8888:8888 notebook:1.0  bash
