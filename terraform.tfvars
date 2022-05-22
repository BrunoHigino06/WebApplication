  #Network module inputs
  #VPC inputs
  vpc = {
    name = "Main"
    Network_CIDR = "10.0.0.0/16"
  }

  # Internet Gateway inputs
  IGW_name = "IGW"

  #Subnet inputs
  N_Subnets = "6"
  #Public Subnet Inputs
  #N_PublicSubnet = "3"
  Public_cidr_block = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  Public_subnet_az  = ["us-east-1a", "us-east-1b", "us-east-1c"]

  #Private Subnet Inputs
  #N_PrivateSubnet = "3"
  Private_cidr_block = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  Private_subnet_az  = ["us-east-1a", "us-east-1b", "us-east-1c"]

  #Route Table inputs
  rt_names = ["PublicRT", "PrivateRT"]

  #Security inputs
  sg_names = ["BastionSG", "PublicSG", "PrivateSG"]

  #Security groups rules inputs
  #Bastion SG rules inputs
  #Bastion Ingress
  BastionIngress_from_port = ["22", "80"]
  BastionIngress_to_port = ["22", "80"]
  BastionIngress_protocol = ["tcp", "tcp"]
  BastionIngress_cidr_blocks = ["0.0.0.0/0", "0.0.0.0/0"]

  #Bastion Egress
  BastionEgress_from_port = ["0"]
  BastionEgress_to_port = ["65535"]
  BastionEgress_protocol = ["tcp"]
  BastionEgress_cidr_blocks = ["0.0.0.0/0"]

  #Public SG rules inputs
  #Public Ingress
  PublicIngress_from_port = ["80", "22"]
  PublicIngress_to_port = ["80", "22"]
  PublicIngress_protocol = ["tcp", "tcp"]
  PublicIngress_cidr_blocks = ["0.0.0.0/0", "10.0.1.0/24"]

  #Public Egress
  PublicEgress_from_port = ["0"]
  PublicEgress_to_port = ["65535"]
  PublicEgress_protocol = ["tcp"]
  PublicEgress_cidr_blocks = ["0.0.0.0/0"]

  #Private SG rules inputs
  #Private Ingress
  PrivateIngress_from_port = ["22", "80", "80", "80"]
  PrivateIngress_to_port = ["22", "80", "80", "80"]
  PrivateIngress_protocol = ["tcp", "tcp", "tcp", "tcp"]
  PrivateIngress_cidr_blocks = ["10.0.1.0/24", "10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

  #Private Egress
  PrivateEgress_from_port = ["0"]
  PrivateEgress_to_port = ["65535"]
  PrivateEgress_protocol = ["tcp"]
  PrivateEgress_cidr_blocks = ["0.0.0.0/0"]

  #Network ACL inputs
  Network_ACL_Names = ["BastionACL", "PublicACL", "PrivateACL"]

  #Network ACL's rules inputs
  #Bastion ACL's rules inputs (ingress first)
  BastionACL_rule_number = ["100", "101", "102", "103", "104", "105", "106", "100"]
  BastionACL_egress = ["false", "false", "false", "false", "false", "false", "false", "true"]
  BastionACL_protocol = ["tcp", "-1", "-1", "-1", "-1", "-1", "tcp", "-1"]
  BastionACL_rule_action = ["allow", "allow", "allow", "allow", "allow", "allow", "allow", "allow"]
  BastionACL_cidr_block = ["0.0.0.0/0", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24", "0.0.0.0/0", "0.0.0.0/0"]
  BastionACL_from_port = ["22", "0", "0", "0", "0", "0", "80", "0"]
  BastionACL_to_port = ["22", "65535", "65535", "65535", "65535", "65535", "80", "0"]

  #Public ACL's rules inputs (ingress first)
  PublicACL_rule_number = ["100","101","100"]
  PublicACL_egress = ["false", "false", "true"]
  PublicACL_protocol = ["tcp", "tcp", "-1"]
  PublicACL_rule_action = ["allow", "allow", "allow"]
  PublicACL_cidr_block = ["10.0.1.0/24", "0.0.0.0/0", "0.0.0.0/0"]
  PublicACL_from_port = ["22", "80", "0"]
  PublicACL_to_port = ["22", "80", "65535"]

  #Private ACL's rules inputs (ingress first)
  PrivateACL_rule_number = ["100","101", "102", "103", "104", "105", "100"]
  PrivateACL_egress = ["false", "false", "false", "false", "false", "false", "true"]
  PrivateACL_protocol = ["tcp", "tcp", "tcp", "tcp", "tcp", "tcp", "-1"]
  PrivateACL_rule_action = ["allow", "allow", "allow", "allow", "allow", "allow", "allow"]
  PrivateACL_cidr_block = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24", "0.0.0.0/0"]
  PrivateACL_from_port = ["0", "0", "0", "0", "0", "0", "0"]
  PrivateACL_to_port = ["65535", "65535", "65535", "65535", "65535", "65535", "65535"]

  #Packer module inputs
  GImage_name = "Nginx_image"
  GManifest_path = "./manifest.json"
  username = "ubuntu"

  #instance module input
  #Key Pair input
  key_name = "my_keyPair"
  #Public2 web instances input
  public2_instances_name = ["PublicApp1"]
  #Public3 web instances input
  public3_instances_name = ["PublicApp2"]
  #Bastion web instances input
  bastion_instances_name = ["Bastion1"]
  #Private1 web instances input
  private1_instances_name = ["PrivateApp1"]
  #Private2 web instances input
  private2_instances_name = ["PrivateApp2"]
  #Private3 web instances input
  private3_instances_name = ["PrivateApp3"]