#!/bin/bash
cd ~
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
docker rmi $(docker images -q)
aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/g9h5h7f8
docker build -t demorepo .
docker tag demorepo:latest public.ecr.aws/g9h5h7f8/demorepo:latest
docker push public.ecr.aws/g9h5h7f8/demorepo:latest
docker run -d --name my-containers -p 8085:8080 public.ecr.aws/g9h5h7f8/demorepo:latest
