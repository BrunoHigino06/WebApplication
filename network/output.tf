#VPC outputs
output "vpc_output" {
  value = {
    vpc_name = aws_vpc.main.tags.Name
    vpc_id = aws_vpc.main.id
    vpc_cidr_block = aws_vpc.main.cidr_block
  }
}

#Public outputs
output "PublicSubnet_output" {
  value = {
    public_name = aws_subnet.PublicSubnets[*].tags.Name
    public_id = aws_subnet.PublicSubnets[*].id
    public_cidr_block = aws_subnet.PublicSubnets[*].cidr_block
  }
}

#Private outputs
output "PrivateSubnet_output" {
  value = {
    Private_name = aws_subnet.PrivateSubnets[*].tags.Name
    Private_id = aws_subnet.PrivateSubnets[*].id
    Private_cidr_block = aws_subnet.PrivateSubnets[*].cidr_block
  }
}

#Security groups output
output "public_securityGroups_ids" {
  value = aws_security_group.SecurityGroups[*].id
}

output "Network" {
  value = {
      name = [aws_vpc.main.tags.Name, aws_subnet.PublicSubnets[*].tags.Name, aws_subnet.PrivateSubnets[*].tags.Name]
      cidr_block = [aws_vpc.main.cidr_block, aws_subnet.PublicSubnets[*].cidr_block, aws_subnet.PrivateSubnets[*].cidr_block]
  }
}