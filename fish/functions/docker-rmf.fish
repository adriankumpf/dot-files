function docker-rmf --description "# Stop and Remove all containers"
  docker stop (docker ps -a -q); and docker rm (docker ps -a -q)
end
