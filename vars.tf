#Network module vars
#VPC vars
variable "vpc" {
    type = map(any)
        default = {
            name  = ""
            Network_CIDR = ""
        }
}

# Internet Gateway vars
variable "IGW_name" {
    type = string
}

#Subnet vars
variable "N_Subnets" {
    type = number
}
#Public Subnets vars
/*variable "N_PublicSubnet" {
    type = number
}*/
variable "Public_cidr_block" {
    type = list(string)
    description = "List of cidr blocks of public subnets"
}
variable "Public_subnet_az" {
    type = list(string)
    description = "List of cidr blocks of public subnets"
}

# Private Subnets vars
/*variable "N_PrivateSubnet" {
    type = number
}*/
variable "Private_cidr_block" {
    type = list(string)
    description = "List of cidr blocks of public subnets"
}
variable "Private_subnet_az" {
    type = list(string)
    description = "List of az's of private subnets"
}

#Route Table vars
variable "rt_names" {
    type = list(string)
    description = "Name of the Route Tables"
}

#Security groups vars
variable "sg_names" {
    type = list(string)
    description = "Name of the security groups"
}

#Security groups rules vars
#Bastion SG rules vars
#Bastion Ingress
variable "BastionIngress_from_port" {
    type = list(string)
    description = "from_port for bastion security groups ingress rules"
}

variable "BastionIngress_to_port" {
    type = list(string)
    description = "to_port for bastion security groups ingress rules"
}

variable "BastionIngress_protocol" {
    type = list(string)
    description = "protocol for bastion security groups ingress rules"
}

variable "BastionIngress_cidr_blocks" {
    type = list(string)
    description = "cidr_blocks for bastion security groups ingress rules"
}

#Bastion Egress
variable "BastionEgress_from_port" {
    type = list(string)
    description = "from_port for bastion security groups ingress rules"
}

variable "BastionEgress_to_port" {
    type = list(string)
    description = "to_port for bastion security groups ingress rules"
}

variable "BastionEgress_protocol" {
    type = list(string)
    description = "protocol for bastion security groups ingress rules"
}

variable "BastionEgress_cidr_blocks" {
    type = list(string)
    description = "cidr_blocks for bastion security groups ingress rules"
}

#Public SG rules vars
#Public Ingress
variable "PublicIngress_from_port" {
    type = list(string)
    description = "from_port for bastion security groups ingress rules"
}

variable "PublicIngress_to_port" {
    type = list(string)
    description = "to_port for bastion security groups ingress rules"
}

variable "PublicIngress_protocol" {
    type = list(string)
    description = "protocol for bastion security groups ingress rules"
}

variable "PublicIngress_cidr_blocks" {
    type = list(string)
    description = "cidr_blocks for bastion security groups ingress rules"
}

#Public Egress
variable "PublicEgress_from_port" {
    type = list(string)
    description = "from_port for bastion security groups ingress rules"
}

variable "PublicEgress_to_port" {
    type = list(string)
    description = "to_port for bastion security groups ingress rules"
}

variable "PublicEgress_protocol" {
    type = list(string)
    description = "protocol for bastion security groups ingress rules"
}

variable "PublicEgress_cidr_blocks" {
    type = list(string)
    description = "cidr_blocks for bastion security groups ingress rules"
}

#Private SG rules vars
#Private Ingress
variable "PrivateIngress_from_port" {
    type = list(string)
    description = "from_port for bastion security groups ingress rules"
}

variable "PrivateIngress_to_port" {
    type = list(string)
    description = "to_port for bastion security groups ingress rules"
}

variable "PrivateIngress_protocol" {
    type = list(string)
    description = "protocol for bastion security groups ingress rules"
}

variable "PrivateIngress_cidr_blocks" {
    type = list(string)
    description = "cidr_blocks for bastion security groups ingress rules"
}

#Private Egress
variable "PrivateEgress_from_port" {
    type = list(string)
    description = "from_port for bastion security groups ingress rules"
}

variable "PrivateEgress_to_port" {
    type = list(string)
    description = "to_port for bastion security groups ingress rules"
}

variable "PrivateEgress_protocol" {
    type = list(string)
    description = "protocol for bastion security groups ingress rules"
}

variable "PrivateEgress_cidr_blocks" {
    type = list(string)
    description = "cidr_blocks for bastion security groups ingress rules"
}

#Network ACL vars
variable "Network_ACL_Names" {
    type = list(string)
    description = "Names for the network ACL's"
}

#Network ACL's rules vars
#Bastion ACL's rules vars
variable "BastionACL_rule_number" {
    type = list(number)
    description = "Number of the ACL rule"
}
variable "BastionACL_egress" {
    type = list(string)
    description = "Egress option for the ACL rule (true for egress rule or false to ingress rule)"
}
variable "BastionACL_protocol" {
    type = list(string)
    description = "Protocol for the ACL rule"
}
variable "BastionACL_rule_action" {
    type = list(string)
    description = "Rule action (allow or deny) for the ACL rule"
}
variable "BastionACL_cidr_block" {
    type = list(string)
    description = "cidr block for the rule for the ACL rule"
}
variable "BastionACL_from_port" {
    type = list(string)
    description = "First port for the rule for the ACL rule"
}
variable "BastionACL_to_port" {
    type = list(string)
    description = "Last port for the rule for the ACL rule"
}

#Public ACL's rules vars
variable "PublicACL_rule_number" {
    type = list(number)
    description = "Number of the ACL rule"
}
variable "PublicACL_egress" {
    type = list(string)
    description = "Egress option for the ACL rule (true for egress rule or false to ingress rule)"
}
variable "PublicACL_protocol" {
    type = list(string)
    description = "Protocol for the ACL rule"
}
variable "PublicACL_rule_action" {
    type = list(string)
    description = "Rule action (allow or deny) for the ACL rule"
}
variable "PublicACL_cidr_block" {
    type = list(string)
    description = "cidr block for the rule for the ACL rule"
}
variable "PublicACL_from_port" {
    type = list(string)
    description = "First port for the rule for the ACL rule"
}
variable "PublicACL_to_port" {
    type = list(string)
    description = "Last port for the rule for the ACL rule"
}

#Private ACL's rules vars
variable "PrivateACL_rule_number" {
    type = list(number)
    description = "Number of the ACL rule"
}
variable "PrivateACL_egress" {
    type = list(string)
    description = "Egress option for the ACL rule (true for egress rule or false to ingress rule)"
}
variable "PrivateACL_protocol" {
    type = list(string)
    description = "Protocol for the ACL rule"
}
variable "PrivateACL_rule_action" {
    type = list(string)
    description = "Rule action (allow or deny) for the ACL rule"
}
variable "PrivateACL_cidr_block" {
    type = list(string)
    description = "cidr block for the rule for the ACL rule"
}
variable "PrivateACL_from_port" {
    type = list(string)
    description = "First port for the rule for the ACL rule"
}
variable "PrivateACL_to_port" {
    type = list(string)
    description = "Last port for the rule for the ACL rule"
}

#Packer vars
#Golden image infos
variable "GImage_name" {
    type = string
}
variable "GManifest_path" {
    type = string
}
variable "username" {
  type = string
}
#instance module vars
#Key Pair vars
variable "key_name" {
    type = string
}
#Public2 web instances vars
variable "public2_instances_name" {
  type = list(string)
}
#public3 web instances vars
variable "public3_instances_name" {
  type = list(string)
}
#Bastion instances vars
variable "bastion_instances_name" {
  type = list(string)
}

#Private1 web instances vars
variable "private1_instances_name" {
  type = list(string)
}

#Private2 web instances vars
variable "private2_instances_name" {
  type = list(string)
}

#Private3 web instances vars
variable "private3_instances_name" {
  type = list(string)
}