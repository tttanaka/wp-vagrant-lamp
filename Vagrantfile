# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ubuntu/trusty64"

  # Forward MySql port on 33066, used for connecting admin-clients to localhost:33066
  config.vm.network "forwarded_port", guest: 3306, host: 33066
  # Forward http port on 8080, used for connecting web browsers to localhost:8080
  config.vm.network "forwarded_port", guest: 80, host: 8080
  # Forward http port on 8025, used for connecting web browsers to MailHog
  config.vm.network "forwarded_port", guest: 8025, host: 8025

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.33.10"

  # Add domain to etc/hosts
  config.vm.hostname = "local.dev"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder "./web", "/var/www/web", :mount_options => ["dmode=777", "fmode=666"]

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:

  config.vm.provider "virtualbox" do |vb|
    vb.customize [
      "modifyvm", :id,
      "--memory", "1024"
    ]
  end

  # Define the setup file: A (shell) script that runs after first setup of your box (= provisioning)
  config.vm.provision :shell, path: "provision.sh"

end
