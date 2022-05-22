packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

#Golden image vars
variable "GImage_name" {
    default = ""
}
variable "GManifest_path" {
    default = ""
}
variable "username" {
    default = ""
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "${var.GImage_name}"
  instance_type = "t2.micro"
  region        = "us-east-1"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-xenial-16.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "${var.username}"
  tags = {
    Name = var.GImage_name
    Env = "production"
  }
}

build {
  name    = "${var.GImage_name}"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]
  provisioner "shell" {
    script = "./goldenimage/setup.sh"
  }
  provisioner "file" {
    source = "./goldenimage/index.nginx-debian.html"
    destination = "/home/ubuntu/"
  }
  provisioner "shell" {
    inline = [
        "sudo mv /home/ubuntu/index.nginx-debian.html /var/www/html/index.nginx-debian.html"
      ]
  }  
  post-processor "manifest" {
    output = "${var.GManifest_path}"
    strip_path = true
  }
}