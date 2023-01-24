packer {
  required_plugins {
    docker = {
      version = ">= 0.0.7"
      source  = "github.com/hashicorp/docker"
    }
  }
}

source "docker" "centos7" {
  image  = "centos"
  commit = true
}

build {
  name    = "my-first-image"
  sources = ["source.docker.centos7"]
  provisioner "shell" {
    scripts = [
      "scripts/base_install.sh",
      "scripts/install_python.sh"
    ]
  }

  post-processor "vagrant" {
    keep_input_artifact = true
  }
}