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

The standard provisioning offers a TLS 1.2 based HAProxy configuration.
You can i.e. load a TLS 1.3 HAProxy configuration, which is
also provided in the repository. Change the file in the docker-compose.yml to do so.

You can connect to the VM using the `vagrant ssh` command.

### Test your TLS Configuration with OWASP O-Saft

The docker-compose.yml defines a [OWASP O-Saft](https://www.owasp.org/index.php/O-Saft) container
with a command to check the SSL configuration of HAProxy.

To test your configuration you can simply run the following command:

`docker-compose up --no-color osaft | less`

*(`| less` makes the console output scrollable, `| tee <filename>` saves the console output to a file)*

### Record TLS handshake with Wireshark

You can analyze the whole TLS Handshake with Wireshark.
This guide also works the same with TLS 1.3.

You can also load the prerecorded files from the wireshark folder of this project.

1. Setup a second virtual machine with Linux or
install Wireshark on your host machine.
For the virtual machine, you need to specify the correct
host-only network adapter.
1. To decrypt the last parts of the handshake, set the environment variable
`SSLKEYLOGFILE` to a location your current user has acces to, i.e the home directory:

	`export SSLKEYLOGFILE=$PWD/keys.txt`
1. Open Wireshark
1. Go to `Edit -> Preferences`.
1. In the preference dialog, navigate to `Protocols -> SSL` or `Protocols -> TLS`
1. Set the path to the SSLKEYLOGFILE (the file gets created later on)
1. Start a recording on the matching network interface
1. Use a browser or curl: `curl -k -X GET https://172.28.128.7`
1. Stop the recording and filter for `ssl`
1. You should now be able to see the handshake and also decrypted SSL.
Also check the keys.txt file, to understand what happened.

## Weitere Aufgaben

- [Unterschied Informationssicherheit und Datenschutz](docs/Unterschied-Datentschutz-Informationssicherheit.md)
