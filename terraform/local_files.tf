resource "local_sensitive_file" "hosts_ini" {
  filename = "../ansible/inventory/hosts.ini"
  content = templatefile("${path.module}/templates/ansible_hosts.tpl", {
    mongodb_shards               = google_compute_instance.mongodb_shards
    mongodb_cfgSrv               = google_compute_instance.mongodb_cfgSrv
    ansible_user                 = "dark0ne"
    ansible_ssh_private_key_file = "~/.ssh/gcp_ds_rsa"
  })
}
