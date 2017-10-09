function docker-rm  --wraps "docker stop" --description "Stop all containers"
  docker stop (docker ps -a -q)
end
