# Pyspark Testing Env
Example Repo to have full end to end pyspark testing via docker-compose


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

Thanks @[arempter](https://github.com/arempter) for inspriaing for this repo. Source used in this project can be found [here](https://github.com/arempter/hive-metastore-docker)