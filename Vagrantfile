VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "debian/jessie64"
  config.vm.hostname = "chefsolo.local"
  config.vm.network "private_network", ip: "192.168.234.2"

  config.vm.provider "virtualbox" do |v|
    v.memory = 8048
    v.cpus = 8
    v.customize ["modifyvm", :id, "--cpuexecutioncap", "80"]
  end

  # Chef Configuration
  config.omnibus.chef_version = :latest
  config.berkshelf.enabled = true
  config.berkshelf.berksfile_path = './Berksfile'
  config.vm.provision "chef_solo" do |chef|
    chef.roles_path = "."
    chef.add_role "chefsolo"
    chef.cookbooks_path = '.'
 end

end
