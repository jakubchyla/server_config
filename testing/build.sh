#! /usr/bin/bash

for i in {1..2}; do
  if [ -d "vagrant${i}" ]; then
    mkdir "vagrant${i}"
  fi
  cat << EOF > "./vagrant${i}/Vagrantfile"
Vagrant.configure("2") do |config|
  config.vm.box = "debian/bookworm64"
  config.vm.provider :libvirt do |libvirt|
    libvirt.cpus = 4
    libvirt.memory = 4096
  end
  config.vm
  config.vm.network "private_network", ip: "192.168.33.1${i}"
  config.vm.provision "shell", inline: "apt-get install --yes python-apt-common"
  config.vm.provision "file", source: "~/.ssh/vagrant.pub", destination: "/home/vagrant/.ssh/vagrant.pub"
  config.vm.provision "shell", inline: "cat /home/vagrant/.ssh/vagrant.pub >> /home/vagrant/.ssh/authorized_keys"
end
EOF

done
