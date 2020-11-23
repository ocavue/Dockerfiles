FROM node:14-buster

RUN apt-get update && \
    apt-get install -y python3-pip && \
    rm -rf /var/lib/{apt,dpkg,cache,log} && \
    pip3 --no-cache-dir install coscmd