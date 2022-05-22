#Create the golden image
resource "null_resource" "PackerBuild" {
    provisioner "local-exec" {
        command = "packer build -var GImage_name=${var.GImage_name} -var GManifest_path=${var.GManifest_path} -var username=${var.username} .\\goldenimage\\goldenimage.pkr.hcl"
    }
}

#Show the content of the manifest file as echo
resource "null_resource" "manifestEcho" {
    provisioner "local-exec" {
        command = "echo $(cat ${var.GManifest_path})"
    }
    depends_on = [
      null_resource.PackerBuild
    ]
}