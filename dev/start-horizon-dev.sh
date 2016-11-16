#mkdir rethinkdb_data

echo "Starting..."
echo "Creating RethinkDB container..."
RETHINKDB_DOCKER_ID=$(docker run -d -v `pwd`/rethinkdb_data:/data -p 28015:28015 -p 29015:29015 -p 8080:8080 --name myrethinkdb rethinkdb)

RETHINKDB_DOCKER_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${RETHINKDB_DOCKER_ID})

echo "RETHINKDB_DOCKER_IP = ${RETHINKDB_DOCKER_IP}"

docker run -v `pwd`:/usr/app --name myhorizon rethinkdb/horizon su -s /bin/sh horizon -c "hz serve --bind all --serve-static ./dist --connect ${RETHINKDB_DOCKER_IP}:28015 --project-name myapp --allow-anonymous yes --permissions no --allow-unauthenticated yes --auto-create-collect yes --auto-create-index yes --debug yes /usr/app/"
