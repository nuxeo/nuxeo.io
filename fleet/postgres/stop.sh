# Sometimes, container seems not yet stopped
docker ps | grep $POSTGRES_NAME
if [ $? -eq 0 ]; then
  docker stop $POSTGRES_NAME
fi
docker rm $POSTGRES_NAME
