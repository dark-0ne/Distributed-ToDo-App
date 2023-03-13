#!/bin/bash
ansible-galaxy install -r requirements.yml

ansible-playbook -i inventory/hosts.ini mongodb.yml && \
ansible-playbook -i inventory/hosts.ini mongo_express.yml && \
ansible-playbook -i inventory/hosts.ini redis.yml && \
ansible-playbook -i inventory/hosts.ini nginx.yml && \
ansible-playbook -i inventory/hosts.ini flask.yml && \
ansible-playbook -i inventory/hosts.ini react.yml && \
ansible-playbook -i inventory/hosts.ini test_server.yml && \
ansible-playbook -i inventory/hosts.ini portainer_server.yml && \
xdg-open https://portainer.csilabs.eu/ > /dev/null 2>&1


