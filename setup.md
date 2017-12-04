# windows vagrant env setup

## install vagrant on windows
- download vagrant for windows from Vagrant
## install cygwin (or batun) on windows
- TODO
## install python2.7 on cygwin
- TODO
## install pip on cygwin
- ref [stack overflow](https://stackoverflow.com/questions/18641438/installing-pip-3-2-on-cygwin)
```sh
apt-cyg install python-setuptools
easy_install-2.7 pip
```

## install ansible on cygwin
- first turn off Anti Virus proection
```sh
apt-cyg install python2-devel
apt-cyg install libffi-devel
apt-cyg install openssl-devel
pip install ansible
```
- during the install pynacl it will be very slow
- ref [here](https://boneanu.blogspot.com/2017/07/upgrade-ansible-on-cygwin.html) for the solution
```sh
wget https://github.com/pyca/pynacl/archive/master.zip -O pynacl-master.zip

unzip pynacl-master.zi
cd pynacl-maste
python setup.py build
python setup.py install
```
- or use the following to inspect what happening
```sh
pip install ansible -vvv
```

## vagrant using cygwin ssh binary

- by default vagrant will use a default ssh client on windows under C:\HashiCorp\Vagrant\embedded\usr\bin and C:\HashiCorp\Vagrant\embedded\bin

you can just replace it with the cygwin version by symlink

or put the cygwin bin path into env

- ref [this gist](https://gist.github.com/haf/2843680)

## vagrant using cygwin 

- It isn’t enough to use Ansible as a Vagrant provisioner. Even if you call vagrant from bash or zsh, vagrant won’t be able to find `ansible-playbook`, because it isn’t on the Windows PATH. But even if we put `ansible-playbook` on the Windows PATH, it won’t run, because it needs to use the Cygwin Python.

- To ensure we’re using the Python in our Cygwin environment, we need a way to run ansible-playbook through bash. The solution we came up with was to create a small Windows batch file and place it somewhere on the Windows PATH or Vagrant default path (C:\HashiCorp\Vagrant\bin) as ansible-playbook.bat and ansible.bat

```bat
@echo off

REM If you used the stand Cygwin installer this will be C:\cygwin
set CYGWIN=C:\cygwin

REM You can switch this to work with bash with %CYGWIN%\bin\bash.exe
set SH=%CYGWIN%\bin\zsh.exe

"%SH%" -c "/bin/ansible-playbook %*"
```

- need to change ansible invetory path for cygwin(https://github.com/hashicorp/vagrant/issues/6607)

```rb
if File.file?(".vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory")
  ansible.inventory_path = ".vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory"
end
```

need to change inventory private ssh key for cygwin path
```
ansible_ssh_private_key_file='.vagrant/machines/default/virtualbox/private_key'
```

- need to change the ansible config in `~/.ansible.cfg` to resolve connection reset issue
(https://github.com/geerlingguy/JJG-Ansible-Windows/issues/6)

```
[ssh_connection]
ssh_args = -o ControlMaster=no
```

- need to install python on the guest to collect facts
(https://gist.github.com/gwillem/4ba393dceb55e5ae276a87300f6b8e6f)

```yml
 gather_facts: false
  pre_tasks:
  - name: Install python2 for Ansible
     raw: bash -c "test -e /usr/bin/python || (apt -qqy update && apt install -qqy python
-minimal)"
    register: output
    changed_when:
    - output.stdout != ""
    - output.stdout != "\r\n"
  - name: Gathering Facts
    setup:
```

## debug with ansible directly

```sh
ansible-playbook -i .vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory playbook.yml -vvv
```


## refs
- https://boneanu.blogspot.ro/2016/05/install-ansible-on-cygwin.html 
- https://fedoramagazine.org/using-ansible-provision-vagrant-boxes/
- https://github.com/geerlingguy/ansible-vagrant-examples
