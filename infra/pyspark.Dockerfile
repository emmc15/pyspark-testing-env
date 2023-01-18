FROM python:3.8.16-slim-buster
COPY --from=openjdk:8-jre-slim /usr/local/openjdk-8 /usr/local/openjdk-8

ENV JAVA_HOME /usr/local/openjdk-8

RUN update-alternatives --install /usr/bin/java java /usr/local/openjdk-8/bin/java 1

ARG HADOOP_VERSION=3.3.4
ARG AWS_JAVA_SDK_VERSION=1.12.339

# Install Java and AWS S3 Dependencies for Spark
RUN apt-get update && apt-get install -y curl; \
    curl -O https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/${HADOOP_VERSION}/hadoop-aws-${HADOOP_VERSION}.jar ; \
    curl -O https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/${AWS_JAVA_SDK_VERSION}/aws-java-sdk-bundle-${AWS_JAVA_SDK_VERSION}.jar

WORKDIR /workspace

# Install Poetry
RUN pip install poetry

COPY poetry.lock pyproject.toml ./

RUN poetry config virtualenvs.create false && poetry install ; \
    mv /hadoop-aws-${HADOOP_VERSION}.jar /usr/local/lib/python3.8/site-packages/pyspark/jars/hadoop-aws-${HADOOP_VERSION}.jar ; \
    mv /aws-java-sdk-bundle-${AWS_JAVA_SDK_VERSION}.jar /usr/local/lib/python3.8/site-packages/pyspark/jars/aws-java-sdk-bundle-${AWS_JAVA_SDK_VERSION}.jar

COPY . ./

ENTRYPOINT [ "jupyter-lab", "--allow-root", "--ip=0.0.0.0"]