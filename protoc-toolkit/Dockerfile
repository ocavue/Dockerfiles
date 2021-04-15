FROM golang:1.16-buster as base
WORKDIR /data/

FROM base as builder

# install unzip
RUN apt-get update && apt-get install -y unzip

# install /usr/local/bin/protoc
RUN curl -L -o /tmp/protoc.zip https://github.com/protocolbuffers/protobuf/releases/download/v3.13.0/protoc-3.13.0-linux-x86_64.zip && \
    unzip /tmp/protoc.zip -d /tmp/protoc/ && \
    mv /tmp/protoc/bin/protoc /usr/local/bin/ && \
    chmod +x /usr/local/bin/protoc

# install /go/bin/protoc-gen-go
RUN go get google.golang.org/protobuf/cmd/protoc-gen-go

# install /go/bin/protoc-gen-go-grpc
RUN go get google.golang.org/grpc/cmd/protoc-gen-go-grpc

# install /go/bin/protoc-gen-validate
# installing PGV can currently only be done from source
# the latest version (as of 2020-09-24) has some issue, so I specify a version.
# RUN go get -d github.com/envoyproxy/protoc-gen-validate && \
#     cd $GOPATH/src/github.com/envoyproxy/protoc-gen-validate && \
#     git checkout v0.4.1 && \
#     git log -n 1 && \
#     make build
RUN go get github.com/envoyproxy/protoc-gen-validate

# install /go/bin/protoc-go-inject-tag
RUN go get github.com/favadi/protoc-go-inject-tag

# install /go/bin/protoc-gen-typescript
RUN go get github.com/ocavue/protoc-gen-typescript

# install /go/bin/protoc-gen-gotemplate
RUN go get moul.io/protoc-gen-gotemplate

# install /go/bin/protolint
RUN go get github.com/yoheimuta/protolint/cmd/protolint

# install /go/bin/protoc-gen-json
RUN go get sourcegraph.com/sourcegraph/prototools/cmd/protoc-gen-json

# install /go/bin/protoc-gen-setter
RUN go get github.com/codyaray/proto-go-setter/protoc-gen-setter

# install /usr/local/bin/buf, /usr/local/bin/protoc-gen-buf-breaking, and /usr/local/bin/protoc-gen-buf-lint
RUN PREFIX="/usr/local" && \
    VERSION="0.36.0" && \
    curl -sSL \
        "https://github.com/bufbuild/buf/releases/download/v${VERSION}/buf-$(uname -s)-$(uname -m).tar.gz" | \
        tar -xvzf - -C "${PREFIX}" --strip-components 1

# install /usr/local/bin/kubectl
# https://kubernetes.io/docs/tasks/tools/install-kubectl/
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.18.10/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl && \
    kubectl version --client

# install /usr/local/bin/gomplate
RUN curl -o /usr/local/bin/gomplate -sSL https://github.com/hairyhenderson/gomplate/releases/download/v3.8.0/gomplate_linux-amd64 && \
    chmod 755 /usr/local/bin/gomplate && \
    gomplate --version

# install /go/bin/revive
RUN go get github.com/mgechev/revive

# install /usr/local/bin/golangci-lint
RUN cd /usr/local/ && curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s v1.38.0

# install /usr/lib/llvm-12/bin/clang-format
RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
    echo "deb http://apt.llvm.org/buster/ llvm-toolchain-buster-12 main" | tee -a /etc/apt/sources.list && \
    echo "deb-src http://apt.llvm.org/buster/ llvm-toolchain-buster-12 main" | tee -a /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y clang-format-12 && \
    clang-format-12 --version && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/apt/lists

# install /go/bin/protoc-gen-sql
RUN go get code.guanmai.cn/back_end/protoc-gen-sql

FROM base
COPY --from=builder /usr/local/bin/protoc                   /usr/local/sbin/protoc
COPY --from=builder /go/bin/protoc-gen-go                   /usr/local/sbin/protoc-gen-go
COPY --from=builder /go/bin/protoc-gen-go-grpc              /usr/local/sbin/protoc-gen-go-grpc
COPY --from=builder /go/bin/protoc-go-inject-tag            /usr/local/sbin/protoc-go-inject-tag
COPY --from=builder /go/bin/protoc-gen-validate             /usr/local/sbin/protoc-gen-validate
COPY --from=builder /go/bin/protoc-gen-typescript           /usr/local/sbin/protoc-gen-typescript
COPY --from=builder /go/bin/protoc-gen-gotemplate           /usr/local/sbin/protoc-gen-gotemplate
COPY --from=builder /go/bin/protolint                       /usr/local/sbin/protolint
COPY --from=builder /go/bin/protoc-gen-json                 /usr/local/sbin/protoc-gen-json
COPY --from=builder /go/bin/protoc-gen-setter               /usr/local/sbin/protoc-gen-setter
COPY --from=builder /usr/local/bin/buf                      /usr/local/sbin/buf
COPY --from=builder /usr/local/bin/protoc-gen-buf-breaking  /usr/local/sbin/protoc-gen-buf-breaking
COPY --from=builder /usr/local/bin/protoc-gen-buf-lint      /usr/local/sbin/protoc-gen-buf-lint
COPY --from=builder /usr/local/bin/kubectl                  /usr/local/sbin/kubectl
COPY --from=builder /usr/local/bin/gomplate                 /usr/local/sbin/gomplate
COPY --from=builder /go/bin/revive                          /usr/local/sbin/revive
COPY --from=builder /usr/local/bin/golangci-lint            /usr/local/sbin/golangci-lint
COPY --from=builder /go/bin/protoc-gen-sql                  /usr/local/sbin/protoc-gen-sql
RUN ls -lrth /usr/local/sbin/

