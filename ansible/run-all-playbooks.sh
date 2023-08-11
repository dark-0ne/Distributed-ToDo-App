#!/bin/bash
ansible-galaxy install -r requirements.yml

ansible-playbook -i inventory/hosts.ini mongodb_cfgsrv.yml > ./logs/mongodb_cfgsrv.log&
ansible-playbook -i inventory/hosts.ini mongodb_shards.yml > ./logs/mongodb_shards.log && \
ansible-playbook -i inventory/hosts.ini mongodb_router.yml > ./logs/mongodb_router.log&
ansible-playbook -i inventory/hosts.ini mongo_express.yml > ./logs/mongodb_express.log&
ansible-playbook -i inventory/hosts.ini redis.yml > ./logs/redis.log&
ansible-playbook -i inventory/hosts.ini nginx.yml > ./logs/nginx.log&
ansible-playbook -i inventory/hosts.ini flask.yml > ./logs/flask.log&
ansible-playbook -i inventory/hosts.ini react.yml > ./logs/react.log&
ansible-playbook -i inventory/hosts.ini test_server.yml > ./logs/test_server.log&
ansible-playbook -i inventory/hosts.ini portainer_server.yml > ./logs/portainer_server.log && \
xdg-open https://portainer.csilabs.eu/ > /dev/null 2>&1


