variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  type = map(any)
  default = {
    "mini-project-public-1" = {
      name       = "public-1"
      az         = "us-east-1a"
      cidr_block = "10.0.1.0/24"
      key        = "mini-project-public-1"
    },

    "mini-project-public-2" = {
      name       = "public-2"
      az         = "us-east-1b"
      cidr_block = "10.0.2.0/24"
      key        = "mini-project-public-2"
    }
  }
}
variable "private_subnets" {
  type = map(any)
  default = {
    "mini-project-private-1" = {
      name       = "private-1"
      az         = "us-east-1a"
      cidr_block = "10.0.3.0/24"
    },

    "mini-project-private-2" = {
      name       = "private-2"
      az         = "us-east-1b"
      cidr_block = "10.0.4.0/24"
    }
  }
}

variable "ec2_instance_sg" {
  type = map(any)
  default = {
    name        = "ec2_instance_sg"
    description = "security group for mini-project ec2 instances"
  }
}

variable "ec2_instance_inbound_ports" {
  type    = list(number)
  default = [80, 443]
}

variable "ec2_instance_ssh_port" {
  type    = number
  default = 22
}

variable "alb_sg" {
  type = map(any)
  default = {
    name        = "alb_sg"
    description = "security group for mini-project application load balancer"
  }
}

variable "ec2_instance_sg_ssh_cidr_block" {
  default = ["0.0.0.0/0"]
}

variable "alb_sg_cidr_block" {
  default = ["0.0.0.0/0"]
}

variable "alb_inbound_ports" {
  type    = list(number)
  default = [80, 443]
}

variable "ec2_instance_ami" {
  type    = string
  default = "ami-0778521d914d23bc1"
}

variable "ec2_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ec2_instance_az1" {
  type = map(any)
  default = {
    mp-web-server-1 = {
      az  = "us-east-1a"
      key = "mp-web-server-1"
    }
    mp-web-server-2 = {
      az  = "us-east-1a"
      key = "mp-web-server-2"
    }
  }
}

variable "ec2_instance_az2" {
  type = map(any)
  default = {
    mp-web-server-3 = {
      az  = "us-east-1b"
      key = "mp-web-server-3"
    }
  }
}

variable "ec2_instance_key" {
  type    = string
  default = "ocelot"
}

variable "host_inventory" {
  type = map(any)
  default = {
    filename = "../../ansible/host-inventory"
  }
}

variable "remote_exec" {
  type = map(any)
  default = {
    ssh_user         = "ubuntu"
    private_key_path = "/home/janortop5/mini-project/ansible/ocelot.pem"
  }
}

variable "alb" {
  type = map(any)
  default = {
    name               = "application-lb"
    load_balancer_type = "application"
  }
}

variable "alb_target_group" {
  type = map(any)
  default = {
    name     = "mp-target-group"
    port     = 80
    protocol = "HTTP"
  }
}

#variable "alb_listener_1" {
#  type = map(any)
#  default = {
#    port        = "80"
#    protocol    = "HTTP"
#    action_type = "forward"
#  }
#}

variable "alb_listener_1" {
  type = map(any)
  default = {
    port        = "80"
    protocol    = "HTTP"
    action_type = "redirect"
    status_code = "HTTP_301"
  }
}

variable "alb_listener_2" {
  type = map(any)
  default = {
    port        = "443"
    protocol    = "HTTPS"
    action_type = "forward"
    ssl_policy = "ELBSecurityPolicy-2016-08"
  }
}

variable "domain" {
  type = map(any)
  default = {
    domain    = "eaaladejana.live"
    subdomain = "terraform-test.eaaladejana.live"
    type      = "A"
  }
}

variable "cert" {
  type = map(any)
  default = {
    cert_1 = {
      domain            = "eaaladejana.live"
      validation_method = "DNS"
    }

    cert_2 = {
      domain            = "terraform-test.eaaladejana.live"
      validation_method = "DNS"
    }
  }
}

variable "namedotcom_username" {
  default = "janortop5"
}

variable "namedotcom_token" {
  default = "56e15b07a343ebeadd3eea483ef1e13db6074aa0"
}

variable "tags" {
  type = map(any)
  default = {
    vpc              = "mini-project-vpc"
    internet_gateway = "mini-project-igw"
    publicRT         = "mini-project-publicRT"
    privateRT        = "mini-project-privateRT"
    ec2_instance_sg  = "mini-project-ec2-instance-sg"
    alb_sg           = "mini-project-alb-sg"
    alb              = "mini-project-alb"
    cert             = "mini-project-ssl-cert"
  }
}

