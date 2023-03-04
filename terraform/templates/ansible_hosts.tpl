[mongodb]
%{for host in mongodb~}
${host.name} ansible_host=${host.network_interface[0].access_config[0].nat_ip} private_ip=${host.network_interface[0].network_ip}
%{endfor~}

[redis]
%{for host in redis~}
${host.name} ansible_host=${host.network_interface[0].access_config[0].nat_ip} private_ip=${host.network_interface[0].network_ip}
%{endfor~}

[nginx]
${nginx.name} ansible_host=${nginx.network_interface[0].access_config[0].nat_ip} private_ip=${nginx.network_interface[0].network_ip} cloudflare_api_key=${cloudflare-api-key} cloudflare_api_token=${cloudflare-api-token}

[all:vars]
ansible_user=${ansible_user}
ansible_ssh_private_key_file=${ansible_ssh_private_key_file}
mongodb_admin_pwd=${mongodb_admin_pwd}
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
