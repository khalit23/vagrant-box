packer {
  required_plugins {
    virtualbox = {
      version = ">= 0.0.1"
      source  = "github.com/hashicorp/virtualbox"
    }
  }
}

source "virtualbox-iso" "ubuntu64" {
  guest_os_type    = "Ubuntu_64"
  iso_url          = "http://releases.ubuntu.com/12.04/ubuntu-12.04.5-server-amd64.iso"
  iso_checksum     = "md5:769474248a3897f4865817446f9a4a53"
  ssh_username     = "vagrant"
  ssh_password     = "vagrant"
  ssh_timeout      = "45m"
  shutdown_command = "echo 'packer' | sudo -S shutdown -P now"

  cpus      = "2"
  memory    = "2048"
  disk_size = 20000
}

build {
  sources = ["sources.virtualbox-iso.ubuntu64"]
  provisioner "shell" {
    execute_command = "{{ .Vars }} {{ .Path }}"
    inline_shebang  = "/bin/bash -ex"
    scripts = [
      "scripts/update_packages.sh",
      "scripts/install_python.sh",
      "scripts/install_docker_engine.sh",
      "scripts/install_git.sh",
      "scripts/install_nodejs.sh",
      "scripts/install_bats.sh"
    ]
    pause_before = "10s"
    timeout      = "10s"
  }

  post-processor "vagrant" {
    keep_input_artifact = true
  }
}