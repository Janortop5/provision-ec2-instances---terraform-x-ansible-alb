# altschool-january-mini-project
Using Terraform to setup 3 EC2 instances put behind a load balancer, and integrated with Ansible to provision the web servers.
## Configurations in modules/ec2:
### vpc.tf
- Creates vpc.
- Creates public and private subnets for vpc.
- Creates internet gateway and attaches it to vpc.
- Creates and attaches public and private route tables for public and private subnets and attaches igw to public route table.
### security_groups.tf
- Creates security group for ec2 instances.
- Creates security group for load balancer.
- Sets load balancer for security group to accept http and https traffic from anywhere.
- Sets ec2 security group to accept http and https traffic only from load balancer, and ssh traffic.
### ec2_instance.tf
- Creates two ec2 instances in the first public subnet.
- Creates one ec2 instance in the second public subnet (different availability zone).
- Creates host-inventory file to be used by ansible configuration.
- Confirms ssh connection to instances is ready.
### alb.tf
- Creates load balancer.
- Creates target group for load balancer.
- Adds instances to the target group.
### route_53.tf
- Creates hosted zone for domain.
- Creates A record for subdomain.
- Points subdomain to load balancer.
- Requests acm certificates for domain and wildcards.
- Creates cname records for certifcate validation.
- Validates acm certificates.
### listeners.tf
- Creates HTTP listener on the load balancer and redirects ttraffic to HTTPS.
- Creates HTTPS listener on the load balancer and forwards the traffic to the ec2 instances.
### variables.tf
- Contains variables for Terraform configuration.
### data.tf
- Requests terraform to read information from "aws_route53_zone" for acm certificate validation.
### providers.tf
- Sets aws as required provider and defines plugin version for Terraform configuration.
- Sets required terraform version.
- Specifies aws region for Terraform configuration.
