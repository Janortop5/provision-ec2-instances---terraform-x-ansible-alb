#When the configuration is running, immediately the hosted zone has been created
#add the name servers for the hosted zone to your domain provider dashboard to ensure the configuration
#runs successfully, this is needed for the acm certificate to be validated.
#If the configuration fails, make sure to add the hosted zone name servers to your domain provider's dashboard and apply
#again, that's if you didn't do it when the configuration was running.

module "ec2" {
  source = "../modules/ec2"
  host_inventory = {
    filename = "../ansible/host-inventory"
  }
}

resource "null_resource" "ansible" {

  provisioner "local-exec" {
    command = <<-EOT
              export ANSIBLE_CONFIG=../ansible/ansible.cfg
              ansible-playbook ../ansible/mini-project.yml
    EOT
  }
  depends_on = [
    module.ec2
  ]
}

output "instruction" {
  value = "If the configuration failed, make sure to add aws name servers for your hosted zone to your domain provider's dashboard\nThat's if you didn't do it when the configuration was running"
}
