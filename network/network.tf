#VPC resource
resource "aws_vpc" "main" {
  cidr_block = var.vpc.Network_CIDR

  tags = {
    Name     = var.vpc.name
  }
}
# Internet gateway
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.IGW_name
  }
}

#Subnet Resources
#Public Subents
resource "aws_subnet" "PublicSubnets" {
  count = var.N_Subnets/2
  vpc_id     = aws_vpc.main.id
  cidr_block = var.Public_cidr_block[count.index]
  availability_zone = var.Public_subnet_az[count.index]
  tags = {
    Name = "Public${count.index+1}"
  }
  depends_on = [
    aws_vpc.main
  ]
}
#Private Subnets
resource "aws_subnet" "PrivateSubnets" {
  count = var.N_Subnets/2
  vpc_id     = aws_vpc.main.id
  cidr_block = var.Private_cidr_block[count.index]
  availability_zone = var.Private_subnet_az[count.index]
  tags = {
    Name = "Private${count.index+1}"
  }
  depends_on = [
    aws_vpc.main,
    aws_subnet.PublicSubnets
  ]
}

# Nat gateway
resource "aws_eip" "eipNAT" {
  vpc      = true
}

resource "aws_nat_gateway" "gwNAT" {
  allocation_id = aws_eip.eipNAT.id
  subnet_id     = aws_subnet.PublicSubnets[0].id

  tags = {
    Name = "gwNAT"
  }
  depends_on = [
    aws_internet_gateway.IGW,
    aws_subnet.PrivateSubnets
  ]
}

#Route Table Resources
resource "aws_route_table" "route_tables" {
  count = length(var.rt_names)
  vpc_id = aws_vpc.main.id
  tags = {
    Name = var.rt_names[count.index]
  }
  depends_on = [
    aws_vpc.main
  ]
}

#Public route table association 
resource "aws_route_table_association" "PublicAS" {
  count = var.N_Subnets/2
  subnet_id = aws_subnet.PublicSubnets[count.index].id
  route_table_id = aws_route_table.route_tables[0].id
  depends_on = [
    aws_route_table.route_tables
  ]
}

#Private route table association 
resource "aws_route_table_association" "PrivateAS" {
  count = var.N_Subnets/2
  subnet_id = aws_subnet.PrivateSubnets[count.index].id
  route_table_id = aws_route_table.route_tables[1].id
  depends_on = [
    aws_route_table.route_tables
  ]
}

#Routes for public subnets
resource "aws_route" "IGW_Rotue" {
  route_table_id = aws_route_table.route_tables[0].id
  gateway_id = aws_internet_gateway.IGW.id
  destination_cidr_block = "0.0.0.0/0"
  depends_on = [
    aws_internet_gateway.IGW,
    aws_route_table.route_tables
  ]
}

#Route for private subnets
resource "aws_route" "Nat_Route" {
  route_table_id = aws_route_table.route_tables[1].id
  gateway_id = aws_nat_gateway.gwNAT.id
  destination_cidr_block = "0.0.0.0/0"
  depends_on = [
    aws_internet_gateway.IGW,
    aws_route_table.route_tables
  ]
}

#Security groups
resource "aws_security_group" "SecurityGroups" {
  count = length(var.sg_names)
  vpc_id = aws_vpc.main.id
  name = var.sg_names[count.index]
  description = "Security group for the instaces"
  tags = {
    Name = var.sg_names[count.index]
  }

  depends_on = [
    aws_vpc.main
  ]
}

#BastionSG security group rules
#Ingress Rules
resource "aws_security_group_rule" "BastionIngress" {
  count             = length(var.BastionIngress_cidr_blocks)
  type              = "ingress"
  from_port         = var.BastionIngress_from_port[count.index]
  to_port           = var.BastionIngress_to_port[count.index]
  protocol          = var.BastionIngress_protocol[count.index]
  cidr_blocks       = [var.BastionIngress_cidr_blocks[count.index]]
  security_group_id = aws_security_group.SecurityGroups[0].id
  depends_on = [
    aws_security_group.SecurityGroups
  ]
}

#Egress
resource "aws_security_group_rule" "BastionEgress" {
  count             = length(var.BastionEgress_cidr_blocks)
  type              = "egress"
  from_port         = var.BastionEgress_from_port[count.index]
  to_port           = var.BastionEgress_to_port[count.index]
  protocol          = var.BastionEgress_protocol[count.index]
  cidr_blocks       = [var.BastionEgress_cidr_blocks[count.index]]
  security_group_id = aws_security_group.SecurityGroups[0].id
  depends_on = [
    aws_security_group.SecurityGroups
  ]  
}

#PublicSG security group rules
#Ingress Rules
resource "aws_security_group_rule" "PublicIngress" {
  count             = length(var.PublicIngress_cidr_blocks)
  type              = "ingress"
  from_port         = var.PublicIngress_from_port[count.index]
  to_port           = var.PublicIngress_to_port[count.index]
  protocol          = var.PublicIngress_protocol[count.index]
  cidr_blocks       = [var.PublicIngress_cidr_blocks[count.index]]
  security_group_id = aws_security_group.SecurityGroups[1].id
  depends_on = [
    aws_security_group.SecurityGroups
  ]  
}

#Egress
resource "aws_security_group_rule" "PublicEgress" {
  count             = length(var.PublicEgress_cidr_blocks)
  type              = "egress"
  from_port         = var.PublicEgress_from_port[count.index]
  to_port           = var.PublicEgress_to_port[count.index]
  protocol          = var.PublicEgress_protocol[count.index]
  cidr_blocks       = [var.PublicEgress_cidr_blocks[count.index]]
  security_group_id = aws_security_group.SecurityGroups[1].id
  depends_on = [
    aws_security_group.SecurityGroups
  ]  
}

#PrivateSG security group rules
#Ingress Rules
resource "aws_security_group_rule" "PrivateIngress" {
  count             = length(var.PrivateIngress_cidr_blocks)
  type              = "ingress"
  from_port         = var.PrivateIngress_from_port[count.index]
  to_port           = var.PrivateIngress_to_port[count.index]
  protocol          = var.PrivateIngress_protocol[count.index]
  cidr_blocks       = [var.PrivateIngress_cidr_blocks[count.index]]
  security_group_id = aws_security_group.SecurityGroups[2].id
  depends_on = [
    aws_security_group.SecurityGroups
  ]  
}

#Egress
resource "aws_security_group_rule" "PrivateEgress" {
  count             = length(var.PrivateEgress_cidr_blocks)
  type              = "egress"
  from_port         = var.PrivateEgress_from_port[count.index]
  to_port           = var.PrivateEgress_to_port[count.index]
  protocol          = var.PrivateEgress_protocol[count.index]
  cidr_blocks       = [var.PrivateEgress_cidr_blocks[count.index]]
  security_group_id = aws_security_group.SecurityGroups[2].id
  depends_on = [
    aws_security_group.SecurityGroups
  ]  
}

#Network ACL's
resource "aws_network_acl" "aws_network_acl" {
  count = length(var.Network_ACL_Names)
  vpc_id = aws_vpc.main.id
  tags = {
    Name = var.Network_ACL_Names[count.index]
  }
}

#Network ACL's association
#BastionACL's association
resource "aws_network_acl_association" "BastionACL-1" {
  network_acl_id = aws_network_acl.aws_network_acl[0].id
  subnet_id = aws_subnet.PublicSubnets[0].id
}

#PublicACL's association
resource "aws_network_acl_association" "PublicACL-1" {
  network_acl_id = aws_network_acl.aws_network_acl[1].id
  subnet_id = aws_subnet.PublicSubnets[1].id
}

resource "aws_network_acl_association" "PublicACL-2" {
  network_acl_id = aws_network_acl.aws_network_acl[1].id
  subnet_id = aws_subnet.PublicSubnets[2].id
}

#PrivateACL's association
resource "aws_network_acl_association" "PrivateACL-1" {
  network_acl_id = aws_network_acl.aws_network_acl[2].id
  subnet_id = aws_subnet.PrivateSubnets[0].id
}

resource "aws_network_acl_association" "PrivateACL-2" {
  network_acl_id = aws_network_acl.aws_network_acl[2].id
  subnet_id = aws_subnet.PrivateSubnets[1].id
}

resource "aws_network_acl_association" "PrivateACL-3" {
  network_acl_id = aws_network_acl.aws_network_acl[2].id
  subnet_id = aws_subnet.PrivateSubnets[2].id
}

#Network ACL's rules
#Bastion ACL's rules
resource "aws_network_acl_rule" "BastionACL_rules" {
  count = length(var.BastionACL_cidr_block)
  network_acl_id = aws_network_acl.aws_network_acl[0].id
  rule_number    = var.BastionACL_rule_number[count.index]
  egress         = var.BastionACL_egress[count.index]
  protocol       = var.BastionACL_protocol[count.index]
  rule_action    = var.BastionACL_rule_action[count.index]
  cidr_block     = var.BastionACL_cidr_block[count.index]
  from_port      = var.BastionACL_from_port[count.index]
  to_port        = var.BastionACL_to_port[count.index]
}

#Public ACL's rules
resource "aws_network_acl_rule" "PublicACL_rules" {
  count = length(var.PublicACL_cidr_block)
  network_acl_id = aws_network_acl.aws_network_acl[1].id
  rule_number    = var.PublicACL_rule_number[count.index]
  egress         = var.PublicACL_egress[count.index]
  protocol       = var.PublicACL_protocol[count.index]
  rule_action    = var.PublicACL_rule_action[count.index]
  cidr_block     = var.PublicACL_cidr_block[count.index]
  from_port      = var.PublicACL_from_port[count.index]
  to_port        = var.PublicACL_to_port[count.index]
}

#Private ACL's rules
resource "aws_network_acl_rule" "PrivateACL_rules" {
  count = length(var.PrivateACL_cidr_block)
  network_acl_id = aws_network_acl.aws_network_acl[2].id
  rule_number    = var.PrivateACL_rule_number[count.index]
  egress         = var.PrivateACL_egress[count.index]
  protocol       = var.PrivateACL_protocol[count.index]
  rule_action    = var.PrivateACL_rule_action[count.index]
  cidr_block     = var.PrivateACL_cidr_block[count.index]
  from_port      = var.PrivateACL_from_port[count.index]
  to_port        = var.PrivateACL_to_port[count.index]
}