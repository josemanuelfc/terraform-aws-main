provider "aws" {
  region = "eu-west-1"
}

module "vpc" {
  source     = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
  name       = "demo-vpc"
}

module "subnets" {
  source        = "./modules/subnets"
  vpc_id        = module.vpc.vpc_id
  subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  azs           = ["eu-west-1a", "eu-west-1b"]
  name          = "demo-subnet"
  public_route_table_id = module.vpc.public_route_table_id
}

module "security" {
  source      = "./modules/security"
  name        = "demo-sg"
  description = "Security group demo"
  vpc_id      = module.vpc.vpc_id

  ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

module "ec2" {
  source         = "./modules/compute"
  ami            = "ami-0fc970315c2d38f01"
  instance_type  = "t2.micro"
  subnet_id      = module.subnets.subnet_ids[0]
  sg_ids         = [module.security.sg_id]
  associate_public_ip_address = true
  key_name       = "profesor01"
  name           = "demo-ec2"
  user_data      = <<EOF
#!/bin/bash
yum install -y httpd
echo "Hola desde Terraform" > /var/www/html/index.html
systemctl start httpd
EOF
}
