resource "local_sensitive_file" "hosts_ini" {
  filename = "../ansible/inventory/hosts.ini"
  content = templatefile("${path.module}/templates/ansible_hosts.tpl", {
    mongodb                      = google_compute_instance.mongodb
    mongodb_admin_pwd            = data.google_secret_manager_secret_version.mongodb-pwd.secret_data
    redis                        = google_compute_instance.redis
    ansible_user                 = "dark0ne"
    ansible_ssh_private_key_file = "~/.ssh/gcp_ds_rsa"
  })
}
