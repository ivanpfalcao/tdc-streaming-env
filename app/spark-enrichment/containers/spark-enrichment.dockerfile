FROM apache/spark:3.5.1-python3

RUN chmod 777 -R /opt/spark/

ENV SPARK_VERSION="3.5.1"

ENV PATH=$PATH:/opt/spark/bin:/opt/spark/sbin

# Download Kafka JARs
RUN wget --no-check-certificate -P "/opt/spark/jars" "https://repo1.maven.org/maven2/org/apache/kafka/kafka-clients/${SPARK_VERSION}/kafka-clients-${SPARK_VERSION}.jar" \
    && wget --no-check-certificate -P "/opt/spark/jars" "https://repo1.maven.org/maven2/org/apache/spark/spark-sql-kafka-0-10_2.12/${SPARK_VERSION}/spark-sql-kafka-0-10_2.12-${SPARK_VERSION}.jar" \
    && wget --no-check-certificate -P "/opt/spark/jars" "https://repo1.maven.org/maven2/org/apache/spark/spark-token-provider-kafka-0-10_2.12/${SPARK_VERSION}/spark-token-provider-kafka-0-10_2.12-${SPARK_VERSION}.jar" \
    && wget --no-check-certificate -P "/opt/spark/jars" "https://repo1.maven.org/maven2/org/apache/commons/commons-pool2/2.11.1/commons-pool2-2.11.1.jar"

WORKDIR /app

RUN mkdir -p /app/.ivy2 && spark-shell --conf spark.jars.ivy=/app/.ivy2 --packages org.apache.spark:spark-hadoop-cloud_2.12:${SPARK_VERSION}

COPY spark-enrichment.py .
#COPY config.yaml .
COPY requirements.txt .

USER root

RUN chmod 775 -R /app

RUN pip install --no-cache-dir -r requirements.txt

USER spark

CMD ["spark-submit", "/app/spark-enrichment.py"]
