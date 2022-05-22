#instance module vars
#AMI
variable "web_instances_ami" {
  type = string
}
#Key Pair
variable "key_name" {
    type = string
}

#Security group for the public instances vars
variable "public_instances_SG" {
  type = string
}
#Public2 web instances vars
variable "public2_instances_name" {
  type = list(string)
}
variable "public2_instances_subnet" {
  type = string
}
#public3 web instances vars
variable "public3_instances_name" {
  type = list(string)
}
variable "public3_instances_subnet" {
  type = string
}

#Bastion instances vars
variable "bastion_instances_name" {
  type = list(string)
}
variable "bastion_instances_subnet" {
  type = string
}
variable "bastion_instances_SG" {
  type = string
}

#Security group for the private instances vars
variable "private_instances_SG" {
  type = string
}

#Private1 web instances vars
variable "private1_instances_name" {
  type = list(string)
}
variable "private1_instances_subnet" {
  type = string
}

#Private2 web instances vars
variable "private2_instances_name" {
  type = list(string)
}
variable "private2_instances_subnet" {
  type = string
}

#Private3 web instances vars
variable "private3_instances_name" {
  type = list(string)
}
variable "private3_instances_subnet" {
  type = string
}

#load balance vars
#Target group vars
variable "vpc_id" {
  type = string 
}

# Application load balance vars
variable "AppALB_subnets" {
    type = list(string)
}