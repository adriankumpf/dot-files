function docker-stop  --wraps "docker stop" --description "Stop all containers"
  docker stop (docker ps -a -q)
end
