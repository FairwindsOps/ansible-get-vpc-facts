# Docker Laptop Basics

Ubuntu
------

As a Linux (and thus superior) OS, all you have to do is install it.

`sudo apt-get install docker.io`


OS X
----

Since there is no OS X native option for running containers you'll need to install a few things to use a Linux based virtual machine.

* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [Docker Toolbox](https://www.docker.com/products/docker-toolbox)

## Create a Docker capable VM

Docker Toolbox includes [Docker Machine](https://docs.docker.com/machine/) for creating and managing Docker capable virtual machines. It also includes the Docker client binary which you can use to execute Docker commands on virtual machines directly from an OS X terminal.

The first step is to [create a virtual machine](https://docs.docker.com/machine/get-started/). You will only need to do this once. Once you have a virtual machine you can use `docker-machine` to start and stop it. You can also configure your OS X terminal shell to have the `docker` client communicate with the virtual machine: `eval "$(docker-machine env default)"`.
