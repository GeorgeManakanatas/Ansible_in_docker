#!/bin/bash

while [ $# -gt 0 ] ; do
  case $1 in
    -i | --image) image="$2" ;;
    -c | --container) container="$2" ;;
    -p | --playbook) playbook="$2" ;;
  esac
  shift
done

if [[ ! -z "$image" ]]; then
    echo "Building image"
    sudo docker build -t $image .
else
    echo "Building image with default name"
    sudo docker build -t dockerizedansible .
fi

if [[ ! -z "$container" ]]; then
    echo "Starting container"
    sudo docker run --name $container $image
else
    echo "Starting container from default image"
    sudo docker run --rm --add-host=host.docker.internal:host-gateway \
    -v /home/georgemanakanatas/Documents/projects/Ansible_docker/ansible_playbooks:/play \
    --name ansible_docker_1 dockerizedansible MainPlaybook.yml
fi
