output "vpc_id" {
  value = module.vpc.vpc_id
}

output "subnet_ids" {
  value = module.subnets.subnet_ids
}

output "sg_id" {
  value = module.security.sg_id
}

output "ec2_public_ip" {
  value = module.ec2.public_ip
}

