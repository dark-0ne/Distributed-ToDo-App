ansible-galaxy install -r requirements.ssh

ansible-playbook -i inventory/hosts.ini mongodb.yml
ansible-playbook -i inventory/hosts.ini redis.yml
