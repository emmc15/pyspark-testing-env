# Pyspark Testing Env

![Build and Test Status](https://github.com/emmc15/pyspark-testing-env/actions/workflows/push.yml/badge.svg)

Example Repo to have full end-to-end pyspark testing via docker-compose that allows for the following:

- Quick and Easy setup for local testing and development environment and abstracting the complexity of setting up a pyspark environment
- Full Pyspark Implementation
- Full S3 like implementation with Minio
- Read and write data to S3 and access them as tables in Spark through metastore
- Ability to run pytest on the pyspark container
- Read and write with delta format
- Consistent environment for testing and development with docker-compose and poetry
- Ability to run tests on push with github actions



*NOTE*: This repo is not intended to be used in production. It is only intended to be used for testing purposes only.


## Quickstart

```
docker-compose build
docker-compose up -d
docker exec -it spark-node pytest .
```

## Folder Layout

**infra**: Contains the docker-compose file and the dockerfiles for the spark and minio containers
**src**: Contains the python code
**tests**: Contains the example tests used for working with pyspark with either pytest or unittest
**.github**: Contains the github actions workflow for running the tests on push


## What is `connection_utils.py`?

`connection_utils.py` is a utility file that contains the logic for connecting to the spark cluster and minio s3 cluster/node. It provides functions with sensible defaults for when running tests and accessing services locally with the docker-compose. When running tests it is highly recommeneded to use them, as without them you will need to pass in the connection information for the spark cluster and minio s3 cluster/node. This is not recommended as it will make the tests less portable and more difficult to run locally. The functions in `connection_utils.py` are as follows:

- `create_docker_spark_builder`: Creates a spark builder that is configured to connect to the spark cluster running in docker-compose
- `create_docker_s3_resource`: Creates a boto3 s3 resource that is configured to connect to the minio s3 cluster/node running in docker-compose
- `create_docker_s3_client`: Creates a boto3 s3 client that is configured to connect to the minio s3 cluster/node running in docker-compose


