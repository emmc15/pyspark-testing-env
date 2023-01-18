import src.connections_utils as connections
spark_session = connections.create_docker_spark_builder().getOrCreate()
import pandas as pd

sample_data = pd.DataFrame({"a": [1, 2, 3], "b": [4, 5, 6]})

spark_data = spark_session.createDataFrame(sample_data)
spark_data.write.format("delta").mode("overwrite").saveAsTable("test_table")