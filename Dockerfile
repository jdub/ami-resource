FROM python:3-alpine

ADD http://stedolan.github.io/jq/download/linux64/jq /usr/local/bin/jq

RUN pip --no-cache-dir install awscli

ADD bin /opt/resource

RUN chmod a+rx,go-w /usr/local/bin/jq /opt/resource/*
