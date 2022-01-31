# -*- mode: ruby -*-
# vi: set ft=ruby :
# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

Vagrant.configure("2") do |config|

    config.vm.define :node1 do |config|
      config.vm.box = "ubuntu/focal64"
      config.vm.box_version = "20211026.0.0"
      config.vm.host_name = "node1"
      # config.vm.network "public_network"
      config.vm.network "forwarded_port", guest: 8001, host: 8002
      config.vm.network "forwarded_port", guest: 80, host: 82
      config.vm.network "private_network", ip: "10.145.0.11"
      config.vm.synced_folder "share/", "/home/vagrant/share", disabled: false  #SharedFoldersEnableSymlinksCreate: false
      config.vm.provider :virtualbox do |vb|
          vb.customize ["modifyvm", :id, "--memory", "4096"]
          vb.customize ["modifyvm", :id, "--cpus", "6"]
          vb.gui = false
      end
    #   config.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "~/.ssh/me.pub"      #uncomment this if you want to use your own certs
      config.vm.provision "ansible" do |ansible|
        ansible.playbook = "config/k8s-master.yml"
        ansible.verbose = true
        ansible.extra_vars = {
            node_ip: "10.145.0.11",
        }
      end
    end
  
    config.vm.define :node2 do |config|
      config.vm.box = "ubuntu/focal64"
      config.vm.box_version = "20211026.0.0"
      config.vm.host_name = "node2"
      # config.vm.network "public_network"
      config.vm.network "private_network", ip: "10.145.0.12"
      config.vm.synced_folder "share/", "/home/vagrant/share", disabled: false
      config.vm.provider :virtualbox do |vb|
          vb.customize ["modifyvm", :id, "--memory", "4096"]
          vb.customize ["modifyvm", :id, "--cpus", "4"]
      end
    #   config.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "~/.ssh/me.pub"
      config.vm.provision "ansible" do |ansible|
        ansible.playbook = "config/k8s-client.yml"
        ansible.verbose = true
        ansible.version = "2.2.1.0"
        ansible.extra_vars = {
            node_ip: "10.145.0.12",
        }
      end
    end
  
    config.vm.define :node3 do |config|
      config.vm.box = "ubuntu/focal64"
      config.vm.box_version = "20211026.0.0"
      config.vm.host_name = "node3"
      # config.vm.network "public_network"
      config.vm.network "private_network", ip: "10.145.0.13"
      config.vm.synced_folder "share/", "/home/vagrant/share", disabled: false
      config.vm.provider :virtualbox do |vb|
          vb.customize ["modifyvm", :id, "--memory", "4096"]
          vb.customize ["modifyvm", :id, "--cpus", "4"]
      end
    #   config.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "~/.ssh/me.pub"
      config.vm.provision "ansible" do |ansible|
        ansible.playbook = "config/k8s-client.yml"
        ansible.verbose = true
        ansible.version = "2.2.1.0"
        ansible.extra_vars = {
            node_ip: "10.145.0.13",
        }
      end
    end

    config.vm.define :node4 do |config|
        config.vm.box = "ubuntu/focal64"
        config.vm.box_version = "20211026.0.0"
        config.vm.host_name = "node4"
        # config.vm.network "public_network"
        config.vm.network "private_network", ip: "10.145.0.14"
        config.vm.synced_folder "share/", "/home/vagrant/share", disabled: false
        config.vm.provider :virtualbox do |vb|
            vb.customize ["modifyvm", :id, "--memory", "4096"]
            vb.customize ["modifyvm", :id, "--cpus", "4"]
        end
      #   config.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "~/.ssh/me.pub"
        config.vm.provision "ansible" do |ansible|
          ansible.playbook = "config/k8s-client.yml"
          ansible.verbose = true
        ansible.version = "2.2.1.0"
          ansible.extra_vars = {
              node_ip: "10.145.0.14",
          }
        end
      end
  end
  
  
  # K8s authorization token create 
  # kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user | awk '{print $1}')
  