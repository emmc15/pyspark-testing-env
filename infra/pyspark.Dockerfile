FROM apache/spark-py:3.3.1

ARG HADOOP_VERSION=3.3.4
ARG AWS_JAVA_SDK_VERSION=1.12.339
ARG PYTHON_VERSION=3.9
# Switch to root user
USER 0:0
RUN cd / ; apt-get update && apt-get install -y curl; \
    curl -O https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/${HADOOP_VERSION}/hadoop-aws-${HADOOP_VERSION}.jar ; \
    curl -O https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/${AWS_JAVA_SDK_VERSION}/aws-java-sdk-bundle-${AWS_JAVA_SDK_VERSION}.jar

WORKDIR /workspace

# Install Poetry
RUN pip install poetry

COPY poetry.lock pyproject.toml ./

RUN poetry config virtualenvs.create false && poetry install ; \
    mv /hadoop-aws-${HADOOP_VERSION}.jar /opt/spark/jars/hadoop-aws-${HADOOP_VERSION}.jar ; \
    mv /aws-java-sdk-bundle-${AWS_JAVA_SDK_VERSION}.jar /opt/spark/jars/aws-java-sdk-bundle-${AWS_JAVA_SDK_VERSION}.jar

COPY . ./

ENV PYTHONPATH "/usr/local/lib/python${PYTHON_VERSION}/dist-packages:/usr/lib/python${PYTHON_VERSION}/site-packages:/usr/lib/python3/dist-packages"
# ENTRYPOINT [ "jupyter-lab", "--allow-root", "--ip=0.0.0.0"]