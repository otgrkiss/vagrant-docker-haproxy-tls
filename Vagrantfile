# Vagrant Configuration for PKI and TLS project
Vagrant.configure("2") do |config|
    # Use Ubuntu Bionic from Vagrant Cloud (version 18.04.3)
    config.vm.box = "ubuntu/bionic64"

    # Configure VirtualBox provider
    config.vm.provider "virtualbox" do |vb|
        vb.memory = 2048
    end

    # Don't sync the Vagrant folder (disable default behaviour)
    # The required files get copied with the file provisioner instead
    config.vm.synced_folder '.', '/vagrant', disabled: true

    # Forward the http and https ports on the guest machine could be possible
	# However, https redirects of the webbrowser would fail with the secure HAProxy config
	# In detail, the browser recieves a Strict-Transport-Security header and redirects to port 443
    # config.vm.network "forwarded_port", guest: 80, host: 8080
    # config.vm.network "forwarded_port", guest: 443, host: 8081

	# Better for this playground project
	# The VM now has a private IP address assigned by a DHCP server
	config.vm.network "private_network", type: "dhcp"

    # Move files to the virtual machine
    # Provison the playbook used by ansible
    config.vm.provision "file", source: "provision/playbook.yml", destination: "/tmp/playbook.yml"
    # Provison the src directory
    config.vm.provision "file", source: "src/", destination: "/home/vagrant/pki-projekt"
    
    # Install and run Ansbile on the virtual machine
    # Install ansible manually beacause Vagrants auto install throws an error for this distribution
    config.vm.provision "shell", path: "provision/install-ansible.sh", privileged: true
    # Create a vagrant directory manually because the ansible_local provider checks for it
    # The vagrant directory is not synced, so it stays empty and is not used
    config.vm.provision "shell", inline: "mkdir -p /vagrant"
    # Run the ansible playbook
    config.vm.provision "ansible_local", playbook: "/tmp/playbook.yml"
    
    # Debug Output section
    # Provide debug output to verify all required sources are created
    config.vm.provision "shell", inline: "ls -l /home/vagrant/pki-projekt"
    # Show information about running docker containers
    config.vm.provision "shell", inline: "docker ps", privileged: true
end
