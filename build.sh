#!/bin/bash

[ ! -d ./layer/awscli ] && mkdir -p ./layer/awscli
docker build -t awscli:amazonlinux .
CONTAINER=$(docker run -d awscli:amazonlinux false)
docker cp ${CONTAINER}:/opt/awscli/lib/python2.7/site-packages/ layer/awscli/
docker cp ${CONTAINER}:/opt/awscli/bin/ layer/awscli/
docker rm -f ${CONTAINER}

mv layer/awscli/site-packages/* layer/awscli/

cd layer/awscli/; ln -sf bin/aws aws
zip -r ../layer.zip *
