#Image data
data "aws_caller_identity" "current" {}

data "aws_ami" "nginx_image" {
    owners = [data.aws_caller_identity.current.account_id]
    most_recent = true
    filter {
        name = "name"
        values = [var.GImage_name]
    }
}
#Remove AMI created
resource "null_resource" "AMI_Remove" {
    provisioner "local-exec" {
        command = "aws ec2 deregister-image --image-id ${data.aws_ami.nginx_image.image_id}"
    }
    depends_on = [
      data.aws_ami.nginx_image
    ]
}