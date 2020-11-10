FROM golang:1.15

# https://kubernetes.io/docs/tasks/tools/install-kubectl/
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.18.10/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl && \
    kubectl version --client
