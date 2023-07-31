/*resource "aws_instance" "eks-cluster" {
    ami=var.ami_id
    instance_type =var.instance_type
    key_name="alpine"

    tags = {
        name="eks-cluster-instanec"
    }
  
}*/

#data "aws_availability_zones" "azs" {}
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = var.cidr_block
 #security_group_ids=[security_group.alpha.id]
  azs             = "us-east-1a"     ##data.aws_availability_zones.azs.names
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = true
  enable_vpn_gateway = true
  enable_dns_hostnames = true
  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = "my-cluster-tf"
  cluster_version = "1.24"

  cluster_endpoint_public_access  = true
  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets

  eks_managed_node_groups = {
    green = {
      min_size     = 1
      max_size     = 3
      desired_size = 2

      instance_types = ["t2.small"]
      
    }
  }
}
/*module "web_server_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/http-80"

  name        = "web-server-sg"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      =  module.vpc.vpc_id

  ingress_cidr_blocks = ["10.10.0.0/16"]*/
/*resource "security_group" "alpha" {
    vpc_id=module.vpc.vpc_id
    ingress{
        from_port=22
        to_port=22
        protocol="tcp"
        cidr_block=["0.0.0.0/0"]
    egress{
        from_port=0
        to_port=0
        protocol="-1"
        cidr_block=["0.0.0.0/0"]
    }
    }
  
}*/
