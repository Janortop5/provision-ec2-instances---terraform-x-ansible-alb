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

terraform {
   backend "s3" {
   region         = "us-east-1"
   bucket         = "altschool-tf-state"
   key            = "exam/terraform.tfstate"
   dynamodb_table = "terraform-state-lock"
   encrypt        = true
 }
}
