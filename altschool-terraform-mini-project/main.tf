#When the configuration is running, Immediately the hosted zone has been created
#Add the name servers for the hosted zone to your domain provider dashboard to ensure the configuration
#runs successfully

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
