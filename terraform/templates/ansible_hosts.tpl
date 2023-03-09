[mongodb-shard0]
%{for host in mongodb-shard0~}
${host.name} ansible_host=${host.network_interface[0].access_config[0].nat_ip} private_ip=${host.network_interface[0].network_ip}
%{endfor~}

[mongodb-shard1]
%{for host in mongodb-shard1~}
${host.name} ansible_host=${host.network_interface[0].access_config[0].nat_ip} private_ip=${host.network_interface[0].network_ip}
%{endfor~}

[mongodb-shard2]
%{for host in mongodb-shard2~}
${host.name} ansible_host=${host.network_interface[0].access_config[0].nat_ip} private_ip=${host.network_interface[0].network_ip}
%{endfor~}

[mongodb-cfgsrv]
%{for host in mongodb-cfgsrv~}
${host.name} ansible_host=${host.network_interface[0].access_config[0].nat_ip} private_ip=${host.network_interface[0].network_ip}
%{endfor~}

[mongodb-router]
%{for host in mongodb-router~}
${host.name} ansible_host=${host.network_interface[0].access_config[0].nat_ip} private_ip=${host.network_interface[0].network_ip}
%{endfor~}

[redis]
%{for host in redis~}
${host.name} ansible_host=${host.network_interface[0].access_config[0].nat_ip} private_ip=${host.network_interface[0].network_ip}
%{endfor~}

[nginx]
${nginx.name} ansible_host=${nginx.network_interface[0].access_config[0].nat_ip} private_ip=${nginx.network_interface[0].network_ip} cloudflare_api_key=${cloudflare-api-key}

[flask]
%{for host in flask~}
${host.name} ansible_host=${host.network_interface[0].access_config[0].nat_ip} private_ip=${host.network_interface[0].network_ip}
%{endfor~}

[all:vars]
ansible_user=${ansible_user}
ansible_ssh_private_key_file=${ansible_ssh_private_key_file}
mongodb_admin_pwd=${mongodb_admin_pwd}
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
