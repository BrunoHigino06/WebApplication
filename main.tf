module "network" {
  source = ".\\network\\"
  providers = {
    aws = aws.us
  }

  #VPC vars
  vpc = {
    name = var.vpc.name
    Network_CIDR = var.vpc.Network_CIDR
  }

  # Internet Gateway vars
  IGW_name = var.IGW_name

  #Subnet vars
  N_Subnets = var.N_Subnets
  #Public Subnets vars
  #N_PublicSubnet = var.N_PublicSubnet
  Public_cidr_block = var.Public_cidr_block
  Public_subnet_az = var.Public_subnet_az

  #Private Subnets vars
  #N_PrivateSubnet = var.N_PrivateSubnet
  Private_cidr_block = var.Private_cidr_block
  Private_subnet_az = var.Private_subnet_az

  # Route Table vars
  rt_names = var.rt_names

  #Security groups vars
  sg_names = var.sg_names

  #Security groups rules vars
  #Bastion SG rules vars
  #Bastion Ingress
  BastionIngress_from_port = var.BastionIngress_from_port
  BastionIngress_to_port = var.BastionIngress_to_port
  BastionIngress_protocol = var.BastionIngress_protocol
  BastionIngress_cidr_blocks = var.BastionIngress_cidr_blocks

  #Bastion Egress
  BastionEgress_from_port = var.BastionEgress_from_port
  BastionEgress_to_port = var.BastionEgress_to_port
  BastionEgress_protocol = var.BastionEgress_protocol
  BastionEgress_cidr_blocks = var.BastionEgress_cidr_blocks

  #Public SG rules vars
  #Public Ingress
  PublicIngress_from_port = var.PublicIngress_from_port
  PublicIngress_to_port = var.PublicIngress_to_port
  PublicIngress_protocol = var.PublicIngress_protocol
  PublicIngress_cidr_blocks = var.PublicIngress_cidr_blocks

  #Public Egress
  PublicEgress_from_port = var.PublicEgress_from_port
  PublicEgress_to_port = var.PublicEgress_to_port
  PublicEgress_protocol = var.PublicEgress_protocol
  PublicEgress_cidr_blocks = var.PublicEgress_cidr_blocks

  #Private SG rules vars
  #Private Ingress
  PrivateIngress_from_port = var.PrivateIngress_from_port
  PrivateIngress_to_port = var.PrivateIngress_to_port
  PrivateIngress_protocol = var.PrivateIngress_protocol
  PrivateIngress_cidr_blocks = var.PrivateIngress_cidr_blocks

  #Private Egress
  PrivateEgress_from_port = var.PrivateEgress_from_port
  PrivateEgress_to_port = var.PrivateEgress_to_port
  PrivateEgress_protocol = var.PrivateEgress_protocol
  PrivateEgress_cidr_blocks = var.PrivateEgress_cidr_blocks

  #Network ACL vars
  Network_ACL_Names = var.Network_ACL_Names

  #Network ACL's rules inputs
  #Bastion ACL's rules inputs
  BastionACL_rule_number = var.BastionACL_rule_number
  BastionACL_egress = var.BastionACL_egress
  BastionACL_protocol = var.BastionACL_protocol
  BastionACL_rule_action = var.BastionACL_rule_action
  BastionACL_cidr_block = var.BastionACL_cidr_block
  BastionACL_from_port = var.BastionACL_from_port
  BastionACL_to_port = var.BastionACL_to_port

  #Public ACL's rules inputs
  PublicACL_rule_number = var.PublicACL_rule_number
  PublicACL_egress = var.PublicACL_egress
  PublicACL_protocol = var.PublicACL_protocol
  PublicACL_rule_action = var.PublicACL_rule_action
  PublicACL_cidr_block = var.PublicACL_cidr_block
  PublicACL_from_port = var.PublicACL_from_port
  PublicACL_to_port = var.PublicACL_to_port

  #Private ACL's rules inputs
  PrivateACL_rule_number = var.PrivateACL_rule_number
  PrivateACL_egress = var.PrivateACL_egress
  PrivateACL_protocol = var.PrivateACL_protocol
  PrivateACL_rule_action = var.PrivateACL_rule_action
  PrivateACL_cidr_block = var.PrivateACL_cidr_block
  PrivateACL_from_port = var.PrivateACL_from_port
  PrivateACL_to_port = var.PrivateACL_to_port
}

module "Golden_Image" {
  source = ".\\goldenimage\\"
  providers = {
    aws = aws.us
  }

  #Packer module inputs
  GImage_name = var.GImage_name
  GManifest_path = var.GManifest_path
  username = var.username
}

module "instances" {
  source = ".\\infrastructure\\"
  providers = {
    aws = aws.us
  }
  #instance module input
  #AMI input
  web_instances_ami = module.Golden_Image.image_id

  #Key Pair input
  key_name = var.key_name

  #Public instances
  #Security group for the public instances input
  public_instances_SG = module.network.public_securityGroups_ids[1]

  #Public2 web instances input
  public2_instances_name = var.public2_instances_name
  public2_instances_subnet = module.network.PublicSubnet_output.public_id[1]
  
  #public3 web instances input
  public3_instances_name = var.public3_instances_name
  public3_instances_subnet = module.network.PublicSubnet_output.public_id[2]
  
  #Bastion instances input
  bastion_instances_name = var.bastion_instances_name
  bastion_instances_subnet = module.network.PublicSubnet_output.public_id[0]
  bastion_instances_SG = module.network.public_securityGroups_ids[0]

  #Security group for the public instances input
  private_instances_SG = module.network.public_securityGroups_ids[2]

  #Private1 web instances input
  private1_instances_name = var.private1_instances_name
  private1_instances_subnet = module.network.PrivateSubnet_output.Private_id[0]

  #Private2 web instances input
  private2_instances_name = var.private2_instances_name
  private2_instances_subnet = module.network.PrivateSubnet_output.Private_id[1]

  #Private3 web instances input
  private3_instances_name = var.private3_instances_name
  private3_instances_subnet = module.network.PrivateSubnet_output.Private_id[2]

  #load balance vars
  #Target group vars
  vpc_id = module.network.vpc_output.vpc_id

  # Application load balance vars
  AppALB_subnets = [
    module.network.PublicSubnet_output.public_id[0],
    module.network.PublicSubnet_output.public_id[1],
    module.network.PublicSubnet_output.public_id[2]
  ]
}

module "destroy_null_resources" {
  source = ".\\destroy_null_resources\\"
  providers = {
    aws = aws.us
  }
  GImage_name = var.GImage_name
  key_name = var.key_name
}