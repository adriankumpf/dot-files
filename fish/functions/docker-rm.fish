function docker-rm  --wraps "docker rm" --description "Remove all containers"
  docker rm (docker ps -a -q)
end
