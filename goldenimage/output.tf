#Packer output
output "Manifest_path" {
  value = var.GManifest_path
}

output "Image_name" {
  value = data.aws_ami.nginx_image.name
}

output "Manifest" {
  value = null_resource.manifestEcho.triggers
}

#Image output
output "image_id" {
  value = data.aws_ami.nginx_image.id
}

output "username" {
  value = "${var.username}"
}