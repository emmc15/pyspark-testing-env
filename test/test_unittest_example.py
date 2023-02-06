"""
Example of usng unittest to write data using delta to s3 locally with minio 
"""
import unittest

from src import connections_utils

class TestDeltaWrite(unittest.TestCase):
    
    @classmethod
    def setUpClass(cls):
        cls.spark_session = connections_utils.create_docker_spark_builder("tests").getOrCreate()
    
    @classmethod
    def tearDownClass(cls):
        cls.spark_session.sql("DROP TABLE IF EXISTS test_table")
        cls.spark_session.stop()
        

    def test_write_delta(self):
        df = self.spark_session.createDataFrame([{"a": 1}, {"a": 2}])
        df.write.format("delta").mode("overwrite").saveAsTable("test_table")