resource "local_sensitive_file" "hosts_ini" {
  filename = "../ansible/inventory/hosts.ini"
  content = templatefile("${path.module}/templates/ansible_hosts.tpl", {
    mongodb-shard0               = google_compute_instance.mongodb-shard0
    mongodb-shard1               = google_compute_instance.mongodb-shard1
    mongodb-shard2               = google_compute_instance.mongodb-shard2
    mongodb-cfgsrv               = google_compute_instance.mongodb-cfgsrv
    mongodb-router               = google_compute_instance.mongodb-router
    mongo-express                = google_compute_instance.mongo-express
    mongodb_admin_pwd            = data.google_secret_manager_secret_version.mongodb-pwd.secret_data
    redis                        = google_compute_instance.redis
    nginx                        = google_compute_instance.nginx
    flask                        = google_compute_instance.flask
    portainer-server             = google_compute_instance.portainer-server
    test-server                  = google_compute_instance.test-server
    react-server                 = google_compute_instance.react-server
    cloudflare-api-key           = data.google_secret_manager_secret_version.cloudflare-api-key.secret_data
    ansible_user                 = var.ANSIBLE_USER
    ansible_ssh_private_key_file = "~/.ssh/gcp_ds_rsa"
  })
}

resource "local_sensitive_file" "test_scripts_env" {
  filename = "../services/test_scripts/.env"
  content  = <<EOT
MONGODB_CONNECTION_URL='mongodb://dark0ne:${data.google_secret_manager_secret_version.mongodb-pwd.secret_data}@mongodb-router-0:16985,mongodb-router-1:16985,mongodb-router-2:16985'
EOT
}
