#!/bin/bash
ansible-galaxy install -r requirements.yml

ansible-playbook -i inventory/hosts.ini mongodb.yml -v && \
ansible-playbook -i inventory/hosts.ini redis.yml -v && \
ansible-playbook -i inventory/hosts.ini nginx.yml -v && \
ansible-playbook -i inventory/hosts.ini flask.yml -v
