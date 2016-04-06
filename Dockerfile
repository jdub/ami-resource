FROM python:3-alpine

RUN apk --no-cache add jq

RUN pip --no-cache-dir install awscli

ADD bin /opt/resource
RUN chmod a+rx,go-w /opt/resource/*
