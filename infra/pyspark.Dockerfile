FROM apache/spark-py:3.3.1

ARG HADOOP_VERSION=3.3.4
ARG AWS_JAVA_SDK_VERSION=1.12.339
ARG PYTHON_VERSION=3.9
ARG PYSPARK_JAR_PATH=/opt/spark/jars/

# Switch to root user
USER 0:0

# Meta Store Connection Jar
ADD https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.19/mysql-connector-java-8.0.19.jar ${PYSPARK_JAR_PATH}

# S3 Related Jars
ADD https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/${HADOOP_VERSION}/hadoop-aws-${HADOOP_VERSION}.jar ${PYSPARK_JAR_PATH}
ADD https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/${AWS_JAVA_SDK_VERSION}/aws-java-sdk-bundle-${AWS_JAVA_SDK_VERSION}.jar ${PYSPARK_JAR_PATH}

# Delta Lake Related Jars, versions might change if delta-spark python package is updated
ADD https://repo1.maven.org/maven2/io/delta/delta-core_2.12/2.2.0/delta-core_2.12-2.2.0.jar ${PYSPARK_JAR_PATH}
ADD https://repo1.maven.org/maven2/io/delta/delta-storage/2.2.0/delta-storage-2.2.0.jar ${PYSPARK_JAR_PATH}
ADD https://repo1.maven.org/maven2/org/antlr/antlr4-runtime/4.8/antlr4-runtime-4.8.jar ${PYSPARK_JAR_PATH}
COPY ./infra/hive-site.xml /opt/spark/conf/hive-site.xml

WORKDIR /workspace

COPY poetry.lock pyproject.toml ./

RUN pip install poetry ; \
    poetry config virtualenvs.create false && poetry install 

COPY . ./

ENV PYTHONPATH "/usr/local/lib/python${PYTHON_VERSION}/dist-packages:/usr/lib/python${PYTHON_VERSION}/site-packages:/usr/lib/python3/dist-packages"
ENTRYPOINT [ "jupyter-lab", "--allow-root", "--ip=0.0.0.0"]