Vagrant.require_version ">= 1.6.0"

VAGRANTFILE_API_VERSION = "2"

def env(property)
  envar = ENV[property]
  if envar == nil then
    puts "You need to export an environment variable for #{property}"
    exit 1
  end
  return envar
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.provider "virtualbox" do |v|
    v.memory = 1024 
  end

  config.vm.define "contextual-dev-vm-1" do |box|

    box.vm.box = "ubuntu/trusty64"
    box.vm.hostname = "contextual.com"
    box.vm.network "private_network", ip: "192.168.50.4"

    box.vm.network "forwarded_port", guest: 9000, host: 9000
    box.vm.network "forwarded_port", guest: 3000, host: 80
    box.vm.network "forwarded_port", guest: 3000, host: 3000
    box.vm.network "forwarded_port", guest: 8080, host: 8080

    box.vm.provision "puppet" do |puppet|
      puppet.module_path    = "modules"
      puppet.manifest_file  = "default.pp"
    end
  end
end
