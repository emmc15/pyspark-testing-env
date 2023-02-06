#/bin/bash  
  
  
/usr/bin/mc config host add local http://minio:9000 ${MINIO_ACCESS_KEY} ${MINIO_SECRET_KEY}  
/usr/bin/mc mb local/spark/warehouse
/usr/bin/mc policy download local/spark/warehouse 
exit 0