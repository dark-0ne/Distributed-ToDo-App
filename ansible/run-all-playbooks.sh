#!/bin/bash
ansible-galaxy install -r requirements.yml

ansible-playbook -i inventory/hosts.ini mongodb.yml
ansible-playbook -i inventory/hosts.ini redis.yml
