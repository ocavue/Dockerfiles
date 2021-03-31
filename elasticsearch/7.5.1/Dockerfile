FROM elasticsearch:7.5.1
RUN ./bin/elasticsearch-plugin install https://github.com/NLPchina/elasticsearch-sql/releases/download/7.5.1.0/elasticsearch-sql-7.5.1.0.zip
RUN ./bin/elasticsearch-plugin install --batch https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v7.5.1/elasticsearch-analysis-ik-7.5.1.zip
RUN ./bin/elasticsearch-plugin install https://github.com/medcl/elasticsearch-analysis-pinyin/releases/download/v7.5.1/elasticsearch-analysis-pinyin-7.5.1.zip
