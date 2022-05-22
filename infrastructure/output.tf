#key pair output
output "SSH_key_Content" {
  value = local_file.private_key.content
  sensitive = false
}

#Public2 instances output
output "public2_instances_output" {
    value = {
        private_ip = aws_instance.public2_instances[*].private_ip
        public_ip = aws_instance.public2_instances[*].public_ip
        name = aws_instance.public2_instances[*].tags.Name
    }
}

#public3 instances output
output "public3_instances_output" {
    value = {
        private_ip = aws_instance.public3_instances[*].private_ip
        public_ip = aws_instance.public3_instances[*].public_ip
        name = aws_instance.public3_instances[*].tags.Name
    }
}

#bastion instances output
output "bastion_instances_output" {
    value = {
        private_ip = aws_instance.bastion_instances[*].private_ip
        Bastion_Host_IP_address = aws_instance.bastion_instances[*].public_ip
        name = aws_instance.bastion_instances[*].tags.Name
    }
}

#private1 instances output
output "private1_instances_output" {
    value = {
        private_ip = aws_instance.private1_instances[*].private_ip
        name = aws_instance.private1_instances[*].tags.Name
    }
}

#private2 instances output
output "private2_instances_output" {
    value = {
        private_ip = aws_instance.private2_instances[*].private_ip
        name = aws_instance.private2_instances[*].tags.Name
    }
}

#private3 instances output
output "private3_instances_output" {
    value = {
        private_ip = aws_instance.private3_instances[*].private_ip
        name = aws_instance.private3_instances[*].tags.Name
    }
}

output "Load_balancer_HTTP_DNS" {
    value = aws_lb.PrivateAppALB.dns_name
}

output "Private_Instances_IP_addresses" {
  value = [aws_instance.private1_instances[*].private_ip, aws_instance.private2_instances[*].private_ip, aws_instance.private3_instances[*].private_ip]
}