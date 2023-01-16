"""

"""
import boto3
from delta import configure_spark_with_delta_pip
from pyspark.sql import SparkSession


def create_docker_spark_builder(session_name: str="test") -> SparkSession.Builder:
    """
    Creates a SparkSession.Builder with the settings needed to run in a docker container

    Args:
        session_name (str): Name of session

    Returns:
        SparkSession.Builder: _description_
    """     

    builder = (
        SparkSession.builder
        # Settings to manage performance and speed for testing in local mode
        .master("local[1]")
        .config("spark.driver.host", "127.0.0.1")
        .config("spark.sql.shuffle.partitions", "1")
        .config("spark.ui.enabled", "false")
        .config("spark.driver.memory", "2g")
        # hive-metastore connection settings
        .enableHiveSupport()
        .config("spark.sql.legacy.createHiveTableByDefault", "false")
        .config("hive.metastore.uris", "thrift://hive-metastore:9083")
        .config("spark.sql.catalogImplementation", "hive")
        .config("spark.hadoop.hive.hmshandler.retry.interval", "60")
        .config("spark.hadoop.hive.hmshandler.retry.attempts", "3")
        .config("spark.sql.warehouse.dir", "s3a://spark/warehouse/")
        # s3 connection settings
        .config("spark.hadoop.fs.s3a.access.key", "accesskey")
        .config("spark.hadoop.fs.s3a.secret.key", "secretkey")
        .config("spark.hadoop.fs.s3a.endpoint", "http://minio:9000")
        .config("spark.hadoop.fs.s3a.connection.ssl.enabled", "false")
        .config("spark.hadoop.fs.s3a.path.style.access", "true")
        .config("spark.hadoop.fs.s3a.impl", "org.apache.hadoop.fs.s3a.S3AFileSystem")
        .config("spark.hadoop.fs.s3a.attempts.maximum", "0")
        # Delta Config
        .config("spark.sql.extensions", "io.delta.sql.DeltaSparkSessionExtension")
        .config("spark.sql.catalog.spark_catalog", "org.apache.spark.sql.delta.catalog.DeltaCatalog")
        # name of session
        .appName(session_name)
    )

    builder = configure_spark_with_delta_pip(spark_session_builder = builder)

    return builder


def create_docker_s3_resource():
    """
    Returns default docker s3 resource for minio
    """

    s3_resource = boto3.resource(
        "s3",
        endpoint_url="http://minio:9000",
        aws_access_key_id="accesskey",
        aws_secret_access_key="secretkey",
        verify=False,
    )
    return s3_resource


def create_docker_s3_client():
    """
    Returns default docker s3 client for minio
    """
    s3_client = boto3.client(
        "s3",
        endpoint_url="http://minio:9000",
        aws_access_key_id="accesskey",
        aws_secret_access_key="secretkey",
        verify=False,
    )

    return s3_client