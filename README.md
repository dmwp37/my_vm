# windows vagrant env setup

## install vagrant on windows
- download vagrant for windows from Vagrant
## install cygwin on windows
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


## refs
- https://boneanu.blogspot.ro/2016/05/install-ansible-on-cygwin.html 
- https://fedoramagazine.org/using-ansible-provision-vagrant-boxes/
- https://github.com/geerlingguy/ansible-vagrant-examples
