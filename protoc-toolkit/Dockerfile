FROM golang:1.15-buster as builder
WORKDIR /data/

# install unzip
RUN apt-get update && apt-get install -y unzip

# install /usr/local/bin/protoc
RUN curl -L -o /tmp/protoc.zip https://github.com/protocolbuffers/protobuf/releases/download/v3.13.0/protoc-3.13.0-linux-x86_64.zip && \
    unzip /tmp/protoc.zip -d /tmp/protoc/ && \
    mv /tmp/protoc/bin/protoc /usr/local/bin/ && \
    chmod +x /usr/local/bin/protoc

# install /go/bin/protoc-gen-go
RUN go get github.com/golang/protobuf/protoc-gen-go

# install /go/bin/protoc-go-inject-tag
RUN go get github.com/favadi/protoc-go-inject-tag

# install /go/bin/protoc-gen-validate
# installing PGV can currently only be done from source
RUN go get -d github.com/envoyproxy/protoc-gen-validate && \
    cd $GOPATH/src/github.com/envoyproxy/protoc-gen-validate && \
    make build

# install /go/bin/protoc-gen-typescript
RUN go get github.com/ocavue/protoc-gen-typescript


FROM node:14-buster-slim
RUN npm install -g typescript@3
COPY --from=builder /usr/local/bin/protoc           /usr/local/bin/protoc
COPY --from=builder /go/bin/protoc-gen-go           /usr/local/bin/protoc-gen-go
COPY --from=builder /go/bin/protoc-go-inject-tag    /usr/local/bin/protoc-go-inject-tag
COPY --from=builder /go/bin/protoc-gen-validate     /usr/local/bin/protoc-gen-validate
COPY --from=builder /go/bin/protoc-gen-typescript   /usr/local/bin/protoc-gen-typescript
RUN ls -lrth /usr/local/bin/proto*
