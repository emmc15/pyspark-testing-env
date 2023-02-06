"""
Example of usng pytest to write data using delta to s3 locally with minio 
"""
import pytest
import pandas as pd

from src import connections_utils

@pytest.fixture(scope="session")
def spark_session():
    spark_session = connections_utils.create_docker_spark_builder("tests").getOrCreate()
    yield spark_session
    spark_session.sql("DROP TABLE IF EXISTS test_table")
    spark_session.stop()

def test_write_delta(spark_session):
    df = spark_session.createDataFrame([{"a": 1}, {"a": 2}])
    df.write.format("delta").mode("overwrite").saveAsTable("test_table")
    actual_df = spark_session.sql("SELECT * FROM test_table").toPandas()
    expected_df = pd.DataFrame({"a": [1, 2]})
    pd.testing.assert_frame_equal(actual_df, expected_df)