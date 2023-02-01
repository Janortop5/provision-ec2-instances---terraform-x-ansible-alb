resource "aws_instance" "ec2_instance-1-2" {
  for_each               = var.ec2_instance_az1
  ami                    = var.ec2_instance_ami
  instance_type          = var.ec2_instance_type
  key_name               = var.ec2_instance_key
  subnet_id              = aws_subnet.public_subnets[var.public_subnets.mini-project-public-1.key].id
  vpc_security_group_ids = [aws_security_group.ec2_instance_sg.id]
  availability_zone      = each.value.az

  tags = {
    Name = each.key
  }
}

resource "aws_instance" "ec2_instance-3" {
  for_each               = var.ec2_instance_az2
  ami                    = var.ec2_instance_ami
  instance_type          = var.ec2_instance_type
  key_name               = var.ec2_instance_key
  subnet_id              = aws_subnet.public_subnets[var.public_subnets.mini-project-public-2.key].id
  vpc_security_group_ids = [aws_security_group.ec2_instance_sg.id]
  availability_zone      = each.value.az

  tags = {
    Name = each.key
  }
}

resource "local_file" "host_inventory" {
  filename = var.host_inventory.filename
  content  = "[web_servers]\n${aws_instance.ec2_instance-1-2[var.ec2_instance_az1.mp-web-server-1.key].public_ip}\n${aws_instance.ec2_instance-1-2[var.ec2_instance_az1.mp-web-server-2.key].public_ip}\n${aws_instance.ec2_instance-3[var.ec2_instance_az2.mp-web-server-3.key].public_ip}\n\n[server_1]\n${aws_instance.ec2_instance-1-2[var.ec2_instance_az1.mp-web-server-1.key].public_ip}\n\n[server_2]\n${aws_instance.ec2_instance-1-2[var.ec2_instance_az1.mp-web-server-2.key].public_ip}\n\n[server_3]\n${aws_instance.ec2_instance-3[var.ec2_instance_az2.mp-web-server-3.key].public_ip}"
}

resource "null_resource" "ansible-1-2" {
  for_each = var.ec2_instance_az1
  provisioner "remote-exec" {
    inline = ["echo 'SSH is ready'"]

    connection {
      type        = "ssh"
      user        = var.remote_exec.ssh_user
      private_key = file(var.remote_exec.private_key_path)
      host        = aws_instance.ec2_instance-1-2[each.key].public_ip
    }
  }
}

resource "null_resource" "ansible-3" {
  for_each = var.ec2_instance_az2
  provisioner "remote-exec" {
    inline = ["echo 'SSH is ready'"]

    connection {
      type        = "ssh"
      user        = var.remote_exec.ssh_user
      private_key = file(var.remote_exec.private_key_path)
      host        = aws_instance.ec2_instance-3[each.key].public_ip
    }
  }
}
