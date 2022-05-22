#key pair resources
resource "tls_private_key" "instance_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.instance_key.public_key_openssh
}

resource "local_file" "private_key" {
  content         = tls_private_key.instance_key.private_key_pem
  filename        = "${var.key_name}.pem"
  file_permission = "0400"
}

#Instances resources
#Public2 instances resources
resource "aws_instance" "public2_instances" {
    count = length(var.public2_instances_name)
    ami           = var.web_instances_ami
    instance_type = "t2.micro"
    associate_public_ip_address = true
    subnet_id = var.public2_instances_subnet
    key_name = var.key_name
    vpc_security_group_ids = [var.public_instances_SG]

    tags = {
        Name = var.public2_instances_name[count.index]
    }
    depends_on = [
      aws_key_pair.generated_key
    ]
}

#Public3 instances resources
resource "aws_instance" "public3_instances" {
    count = length(var.public3_instances_name)
    ami           = var.web_instances_ami
    instance_type = "t2.micro"
    associate_public_ip_address = true
    subnet_id = var.public3_instances_subnet
    key_name = var.key_name
    vpc_security_group_ids = [var.public_instances_SG]

    tags = {
        Name = var.public3_instances_name[count.index]
    }
    depends_on = [
      aws_key_pair.generated_key
    ]
}
#Bastion instances resources
#Bastion instance
resource "aws_instance" "bastion_instances" {
    count = length(var.bastion_instances_name)
    ami           = var.web_instances_ami
    instance_type = "t2.micro"
    associate_public_ip_address = true
    subnet_id = var.bastion_instances_subnet
    key_name = var.key_name
    vpc_security_group_ids = [var.bastion_instances_SG]

    tags = {
        Name = var.bastion_instances_name[count.index]
    }
    depends_on = [
      aws_key_pair.generated_key
    ]    
}

#Private instance resources
#private1 instances resources
resource "aws_instance" "private1_instances" {
    count = length(var.private1_instances_name)
    ami           = var.web_instances_ami
    instance_type = "t2.micro"
    associate_public_ip_address = false
    subnet_id = var.private1_instances_subnet
    key_name = var.key_name
    vpc_security_group_ids = [var.private_instances_SG]

    tags = {
        Name = var.private1_instances_name[count.index]
    }
    depends_on = [
      aws_key_pair.generated_key
    ]
}

#private2 instances resources
resource "aws_instance" "private2_instances" {
    count = length(var.private2_instances_name)
    ami           = var.web_instances_ami
    instance_type = "t2.micro"
    associate_public_ip_address = false
    subnet_id = var.private2_instances_subnet
    key_name = var.key_name
    vpc_security_group_ids = [var.private_instances_SG]

    tags = {
        Name = var.private2_instances_name[count.index]
    }
    depends_on = [
      aws_key_pair.generated_key
    ]
}

#private3 instances resources
resource "aws_instance" "private3_instances" {
    count = length(var.private3_instances_name)
    ami           = var.web_instances_ami
    instance_type = "t2.micro"
    associate_public_ip_address = false
    subnet_id = var.private3_instances_subnet
    key_name = var.key_name
    vpc_security_group_ids = [var.private_instances_SG]

    tags = {
        Name = var.private3_instances_name[count.index]
    }
    depends_on = [
      aws_key_pair.generated_key
    ]
}

#load balance resources
#Target group resource
resource "aws_lb_target_group" "PrivateTG" {
  name     = "PrivateTG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"

  tags = {
    "Name" = "PrivateTG"
  }
}

# Application load balance resource
resource "aws_lb" "PrivateAppALB" {
  name               = "PrivateAppALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.public_instances_SG]
  subnets            = var.AppALB_subnets

  enable_deletion_protection = false

  tags = {
    "Name" = "PrivateAppALB"
  }
}

resource "aws_lb_target_group_attachment" "Private1Att" {
    count = length(var.private2_instances_name)
    target_group_arn = aws_lb_target_group.PrivateTG.arn
    target_id        = aws_instance.private1_instances[count.index].private_ip
    port             = "80"
}

resource "aws_lb_target_group_attachment" "Private2Att" {
    count = length(var.private2_instances_name)
    target_group_arn = aws_lb_target_group.PrivateTG.arn
    target_id        = aws_instance.private2_instances[count.index].private_ip
    port             = "80"
}

resource "aws_lb_target_group_attachment" "Private3Att" {
    count = length(var.private3_instances_name)
    target_group_arn = aws_lb_target_group.PrivateTG.arn
    target_id        = aws_instance.private3_instances[count.index].private_ip
    port             = "80"
}

#Forward rule for the load balancer
resource "aws_lb_listener" "PrivateAppALB_forward" {
  load_balancer_arn = aws_lb.PrivateAppALB.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.PrivateTG.arn
  }
}