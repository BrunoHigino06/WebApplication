#Network module outputs
#VPC outputs
output "vpc_output" {
  value = {
    vpc_name = module.network.vpc_output.vpc_name
    vpc_id = module.network.vpc_output.vpc_id
    vpc_cidr_block = module.network.vpc_output.vpc_cidr_block
  }
}

#Subnet Outputs
#Public Subnet outputs
#Public outputs
output "PublicSubnet_output" {
  value = {
    public_name = module.network.PublicSubnet_output.public_name
    public_id = module.network.PublicSubnet_output.public_id
    public_cidr_block = module.network.PublicSubnet_output.public_cidr_block
  }
}

#Private Subnet outputs
output "PrivateSubnet_output" {
  value = {
    Private_name = module.network.PrivateSubnet_output.Private_name
    Private_id = module.network.PrivateSubnet_output.Private_id
    Private_cidr_block = module.network.PrivateSubnet_output.Private_cidr_block
  }
}

#Security groups output
output "public_securityGroups_ids" {
  value = module.network.public_securityGroups_ids
}

#Network outputs
output "Network" {
  value = {
      name = [module.network.Network.name]
      cidr_block = [module.network.Network.cidr_block]
  }
}
#Golden_image module outputs
#Packer output
output "Manifest_path" {
  value = var.GManifest_path
}
output "Image_name" {
  value = module.Golden_Image.Image_name
}
output "image_id" {
  value = module.Golden_Image.image_id
}
output "Manifest" {
  value = module.Golden_Image.Manifest
}
output "username" {
  value = module.Golden_Image.username
}

#Instance module output
#Key pair output
output "SSH_key_Content" {
  value = module.instances.SSH_key_Content
  sensitive = true
}

#Public2 instances output
output "public2_instances_output" {
    value = {
        private_ip = module.instances.public2_instances_output.private_ip
        public_ip = module.instances.public2_instances_output.public_ip
        name = module.instances.public2_instances_output.name
    }
}

#public3 instances output
output "public3_instances_output" {
    value = {
        private_ip = module.instances.public3_instances_output.private_ip
        public_ip = module.instances.public3_instances_output.public_ip
        name = module.instances.public3_instances_output.name
    }
}

#bastion instances output
output "bastion_instances_output" {
    value = {
        private_ip = module.instances.bastion_instances_output.private_ip
        Bastion_Host_IP_address = module.instances.bastion_instances_output.Bastion_Host_IP_address
        name = module.instances.bastion_instances_output.name
    }
}

#Private1 instances output
output "private1_instances_output" {
    value = {
        private_ip = module.instances.private1_instances_output.private_ip
        name = module.instances.private1_instances_output.name
    }
}

#Private2 instances output
output "private2_instances_output" {
    value = {
        private_ip = module.instances.private2_instances_output.private_ip
        name = module.instances.private2_instances_output.name
    }
}

#Private3 instances output
output "private3_instances_output" {
    value = {
        private_ip = module.instances.private3_instances_output.private_ip
        name = module.instances.private3_instances_output.name
    }
}

#Application load balancer output
output "Load_balancer_HTTP_DNS" {
    value = module.instances.Load_balancer_HTTP_DNS
}

output "Private_Instances_IP_addresses" {
  value = module.instances.Private_Instances_IP_addresses
}