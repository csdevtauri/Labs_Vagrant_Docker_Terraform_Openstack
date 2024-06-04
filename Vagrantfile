# Vagrantfile for Terraform Ubuntu
Vagrant.configure("2") do |config|
  config.vm.provider "docker" do |d|
    d.build_dir = "."  # Chemin vers le répertoire contenant le Dockerfile
    d.name = "terraform-ubuntu"  # Nom du conteneur
    d.build_args = ["-t", "terraform-ubuntu:latest"]  # Arguments pour construire et tagger l'image
    d.remains_running = true
  end

  config.ssh.username = "root"
  config.ssh.password = "vagrant"
end