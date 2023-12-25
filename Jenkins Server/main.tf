# VPC module provided has already configured route tables and internet gateway
# https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "jenkins-vpc"
  cidr = var.vpc_cidr

  azs            = ["us-east-1"]
  public_subnets = var.public_subnets

  enable_dns_hostnames = true
  # Specify true to indicate that instances launched into the subnet should be assigned a public IP address
  map_public_ip_on_launch = true

  tags = {
    Name        = "jenkins-vpc"
    Terraform   = "true"
    Environment = "dev"
  }

  public_subnet_tags = {
    Name = "jenkins-subnet"
  }

  redshift_route_table_tags = {
    Name = "jenkins-rt"
  }
}

# SG
# https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/latest
module "sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "jenkins-sg"
  description = "Security Group for Jenkins server"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8081
      protocol    = "tcp"
      description = "HTTP"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "SSH"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  tags = {
    Name = "jenkins-sg"
  }
}

# EC2
# https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest
module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "Jenkins-Server"

  instance_type               = var.instance_type
  key_name                    = "jenkins-server-key"
  monitoring                  = true
  vpc_security_group_ids      = [module.sg.security_group_id] # associate security group to EC2
  subnet_id                   = module.vpc.public_subnets[0]  # associate the EC2 to the public subnet of the created VPC 
  associate_public_ip_address = true
  # Add starting script
  user_data         = file("jenkins-install.sh")
  availability_zone = "us-east-1"

  tags = {
    Name        = "Jenkins-Server"
    Terraform   = "true"
    Environment = "dev"
  }
}
