# Git, Ansible, Jenkins, Docker, Kubernetes DevOps Pipeline #


## Create New VirtualBox Virtual Machines (VMs) ##

Create a Master VM and any number of Client VMs.

Mount and install VirtualBox Guest Additions.

Maximize, or scale, your VM window(s).

(Optional) Enable bi-directional copy and paste use clipboard between host machine and VMs. Click the following tab on your VMs:
```
Devices/Shared Clipboard/Bidirectional
```

Ensure you are running an up-to-date Operating System (OS). If you are not, follow the on-screen updates/upgrades.

## Install Ansible ##
Install Ansible on your Master VM. Ensure you are following the most up-to-date documentation: https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html

Installation requires you to run the  following commands on your Master VM:

```
sudo apt update
sudo apt install software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
```

### Modify hosts files: ###
Obtain the IP Address(es) of your Client VM(s). Add the IP Address(es) to both of the following hosts files:

```
/etc/hosts
/etc/ansible/hosts
```

NOTE: The Ansible hosts file is called the Inventory.

### Configure SSH: ###

Install openssh-server on Client VM:
```
sudo apt install openssh-server
```

Generate a new SSH Key and copy the public key to your Client VM:
```
ssh-keygen
ssh-copy-id client@client
```