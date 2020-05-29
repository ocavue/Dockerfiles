FROM golang:1.14-stretch

WORKDIR /data/build/
RUN apt-get update && apt-get install -y unzip

ENV PROTOC_ZIP=protoc-3.11.4-linux-x86_64.zip
RUN curl -OL https://github.com/protocolbuffers/protobuf/releases/download/v3.11.4/protoc-3.11.4-linux-x86_64.zip
RUN unzip -o $PROTOC_ZIP -d /usr/local bin/protoc
RUN unzip -o $PROTOC_ZIP -d /usr/local 'include/*'
