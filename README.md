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
- Adds instances to the target group
