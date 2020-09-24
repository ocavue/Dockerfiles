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
RUN go get -u -v github.com/golang/protobuf/protoc-gen-go

# install /go/bin/protoc-go-inject-tag
RUN go get -u -v github.com/favadi/protoc-go-inject-tag

# install /go/bin/protoc-gen-typescript
RUN go get -u -v github.com/ocavue/protoc-gen-typescript

# install /go/bin/protoc-gen-gotemplate
RUN go get -u -v moul.io/protoc-gen-gotemplate

# install /go/bin/protolint
RUN go get -u -v github.com/yoheimuta/protolint/cmd/protolint

# install /go/bin/protoc-gen-validate
# installing PGV can currently only be done from source
RUN go get -d github.com/envoyproxy/protoc-gen-validate@v0.4.1 && \
    cd $GOPATH/src/github.com/envoyproxy/protoc-gen-validate && \
    git status && \
    make build

FROM node:14-buster-slim
RUN npm install -g typescript@3 && npm cache clean --force
COPY --from=builder /usr/local/bin/protoc           /usr/local/bin/protoc
COPY --from=builder /go/bin/protoc-gen-go           /usr/local/bin/protoc-gen-go
COPY --from=builder /go/bin/protoc-go-inject-tag    /usr/local/bin/protoc-go-inject-tag
COPY --from=builder /go/bin/protoc-gen-validate     /usr/local/bin/protoc-gen-validate
COPY --from=builder /go/bin/protoc-gen-typescript   /usr/local/bin/protoc-gen-typescript
COPY --from=builder /go/bin/protoc-gen-gotemplate   /usr/local/bin/protoc-gen-gotemplate
COPY --from=builder /go/bin/protolint               /usr/local/bin/protolint
RUN ls -lrth /usr/local/bin/proto*
