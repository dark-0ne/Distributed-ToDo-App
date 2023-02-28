[mongodb-shards]
%{for host in mongodb_shards~}
${host.name} ansible_host=${host.network_interface[0].access_config[0].nat_ip} private_ip=${host.network_interface[0].network_ip}
%{endfor~}

[mongodb-cfgSrv]
${mongodb_cfgSrv.name} ansible_host=${mongodb_cfgSrv.network_interface[0].access_config[0].nat_ip} private_ip=${mongodb_cfgSrv.network_interface[0].network_ip}

[all:vars]
ansible_user=${ansible_user}
ansible_ssh_private_key_file=${ansible_ssh_private_key_file}
