
#VPC vars
variable "vpc" {
    type = map(any)
        default = {
            name  = ""
            Network_CIDR = ""
        }
}

# Internet Gateway
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
    description = "List of az's of public subnets"
}

# Private Subnets vars
/*variable "N_PrivateSubnet" {
    type = number
}*/
variable "Private_cidr_block" {
    type = list(string)
    description = "List of cidr blocks of private subnets"
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
#Bastion Ingress vars
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

#Bastion Egress vars
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
#Public Ingress vars
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

#Public Egress vars
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
#Private Ingress vars
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

#Private Egress vars
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
    type = list(number)
    description = "First port for the rule for the ACL rule"
}
variable "BastionACL_to_port" {
    type = list(number)
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