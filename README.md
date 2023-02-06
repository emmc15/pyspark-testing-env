# Pyspark Testing Env
Example Repo to have full end to end pyspark testing via docker-compose


*NOTE*: This repo is not intended to be used in production. It is only intended to be used for testing purposes only.

## Quickstart

```
docker-compose build
docker-compose up -d
docker exec -it spark-node pytest .
```

## Environment Overview



### pyspark container

### hive container

### minio container



# Credit

Thanks @[arempter](https://github.com/arempter) for inspriaing for this repo. Source used in creating hive-metastore for this project can be found [here](https://github.com/arempter/hive-metastore-docker)