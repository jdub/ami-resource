FROM alpine:latest

RUN apk --no-cache add py3-pip jq

RUN pip --no-cache-dir --disable-pip-version-check install awscli

ADD bin /opt/resource
