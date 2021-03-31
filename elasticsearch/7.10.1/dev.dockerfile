FROM elasticsearch:7.10.1
RUN ./bin/elasticsearch-plugin install --batch https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v7.10.1/elasticsearch-analysis-ik-7.10.1.zip
RUN ./bin/elasticsearch-plugin install https://github.com/medcl/elasticsearch-analysis-pinyin/releases/download/v7.10.1/elasticsearch-analysis-pinyin-7.10.1.zip

RUN curl -sL https://rpm.nodesource.com/setup_14.x | bash -
RUN yum install -y nodejs
RUN yum install epel-release -y
RUN yum install jq -y && \
    jq --version
RUN yum install -y vim
RUN npm install -g 'elasticdump@6.68.0'
