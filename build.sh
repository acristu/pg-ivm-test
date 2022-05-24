#!/usr/bin/env bash
set -ex

#git clone https://github.com/sraoss/pgsql-ivm.git

#docker build -t pgivm:14 -f Dockerfile .
docker build -f Dockerfile.dev -t pgivm-dev:14 .

# docker push pgivm:14


# docker run --rm -it -e POSTGRES_PASSWORD=password pgivm-dev:14 bash
