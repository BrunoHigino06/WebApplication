#Image data
data "aws_caller_identity" "current" {}

data "aws_ami" "nginx_image" {
    owners = [data.aws_caller_identity.current.account_id]
    most_recent = true
    filter {
        name = "name"
        values = [var.GImage_name]
    }
    depends_on = [
      null_resource.PackerBuild
    ]
}