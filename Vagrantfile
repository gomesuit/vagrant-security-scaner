# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.synced_folder ".", "/home/vagrant/sync", disabled: true

  config.vm.box = "centos/7"

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "3072"]
  end

  config.vm.define :master do |host|
    _HOSTNAME = "master"
    _PRIVATE_IP_ADDRESS = "192.168.33.10"

    host.vm.hostname = _HOSTNAME
    host.vm.network "private_network", ip: _PRIVATE_IP_ADDRESS
    #host.vm.provision :shell, path: "install-vuls.sh"
    #host.vm.provision :shell, path: "install-skipfish.sh"
    #host.vm.provision :shell, path: "install-nikto.sh"
    #host.vm.provision :shell, path: "install-namp.sh"
    host.vm.provision :shell, path: "install-wpscan.sh"
  end

end
