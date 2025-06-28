resource "null_resource" "get_hostname" {
  provisioner "local-exec" {
    command = "hostname"  # Command to get the hostname
  }
}

output "local_hostname" {
  value = resource.null_resource.get_hostname.triggers["command_output"]
}
