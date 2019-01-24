# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vbguest.auto_update = true
  config.ssh.forward_agent = true
  config.vm.synced_folder "./", "/home/vagrant/workfolder"
  config.vm.synced_folder "~/.aws", "/home/vagrant/.aws"

  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 1
        v.customize [ "guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 10000 ]
  end
  config.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "~/.ssh/id_rsa.pub"
  config.vm.provision "file", source: "~/.ssh/id_rsa", destination: "~/.ssh/id_rsa"

  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-add-repository -y ppa:ansible/ansible
    sudo apt-get update
    sudo apt-get autoremove -y
    sudo apt-get install -y python-pip ansible
    sudo pip install --upgrade pip
    sudo pip install awscli boto netaddr -U
  SHELL

  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "kitchen.yml"
  end
end
