# Dockerized HAProxy with TLS Configuration Provisioned with Vagrant

To learn more about this repository, review the [Technical Documentation](docs/Tech-Paper.md)

## Requirements

- Vagrant
- VirtualBox

## Architecture

![Project Archtecture](docs/Architecture.png)

## Provision

Run `vagrant up` to start a virtual machine.
Review the output from Vagrant. Check if the `certificate-chain.pem` is generated and three Docker containers are running.

If you want the newest version of Guest Additions on the machine,
you can install the [Vagrant VB Guest Plugin](https://github.com/dotless-de/vagrant-vbguest). The Guest Additons are not required
for the VM.

## And Now?

Here are some activities that can be done with the VM. 

### Access the Web Page

You can access the VM from a private IP address. To find the IP address assigned to the VM
type `vagrant ssh` and after that `ip a` to list all network interfaces.

If everything works fine, a web page is displayed under the ip address. 
You will get a security warning beacuse of the self signed certificate. 
In that case you can add a security exception.

### Try out different HAProxy configuration

The standard provisioning offers a TLS 1.3 based HAProxy configuration.
You can i.e. load a TLS 1.2 HAProxy configuration, which is
also provided in the repository. Change the file in the docker-compose.yml to do so.

You can connect to the VM using the `vagrant ssh` command.

### Test your TLS Configuration with OWASP O-Saft

The VM contains an installation of [OWASP O-Saft](https://www.owasp.org/index.php/O-Saft) in the
Vagrant home directory.

To test your configuration you can use the `+check` argument:

`./o-saft +check localhost | tee localhost-check.txt`
