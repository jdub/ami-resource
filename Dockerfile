FROM python:3-alpine

ADD http://stedolan.github.io/jq/download/linux64/jq /usr/local/bin/jq

RUN pip --no-cache-dir install awscli

COPY in    /opt/resource/in
COPY check /opt/resource/check
COPY out   /opt/resource/out

RUN chmod +x /usr/local/bin/jq /opt/resource/*
