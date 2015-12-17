# Neap Box

A Vagrant box for [Neap](https://github.com/e7d/neap) development.

## Read me first

This project aims to give you the necessary tools to build yourself the Neap Box.  
If you only want to use the Neap Box, you will never have to build it yourself. Instead, get it from [Atlas by Hashicorp](https://atlas.hashicorp.com/):
* [Neap Box](https://atlas.hashicorp.com/e7d/boxes/neap-box)

## About

**Version:** 0.0.1

**Web:** Coming later, [neap.io](http://neap.io)

**Project Owner:** Michaël "[e7d](https://github.com/e7d)" Ferrand

## Prerequisites

In order to build the Neap Box effectively, you'll need to have a few tools installed:
1. Install [Git](https://git-scm.com)
1. Install [VirtualBox](http://virtualbox.org)
1. Install [Vagrant](http://vagrantup.com)

### Windows-specific ###

1. Add the Git executables to your path
1. Install [Vagrant::WinNFSd](https://github.com/winnfsd/vagrant-winnfsd), to use NFS on a Windows host  
`vagrant plugin install vagrant-winnfsd`

### Recommended

1. Use a development workstation with at least 2 cores and 8GB of RAM, as Vagrant should be allocated 1GB of RAM
1. Install [Vagrant::VBGuest](https://github.com/dotless-de/vagrant-vbguest), to manage the host's VirtualBox Guest Additions on the guest system  
`vagrant plugin install vagrant-vbguest`

## Build ##

1. `git clone https://github.com/e7d/neap-box.git` to clone the latest version
1. Change into the directory `neap-box`
1. Run `vagrant up`
1. Run `vagrant package --output neap.box`
1. Run `vagrant package --output neap.box`

## What you get ##

### Software stack ###

Neap box uses a mixture of Vagrant's [shell provisioner](https://docs.vagrantup.com/v2/provisioning/shell.html) to kick things off.

Once Vagrant is done provisioning the VM, you will have a box running the latest Debian 8 (aka Jessie) containing:

* [Nginx](http://nginx.com/), as web server, with:
  * [Nginx RTMP module](https://github.com/arut/nginx-rtmp-module), as streaming server (RTMP, HLS and DASH protocols)
* [PHP 7.0](http://php.net/), as web scripting language, with:
    * [PHP-FPM](http://php-fpm.org/), as PHP process manager
    * Soon: [Memcached](http://memcached.org/), as memory object cache
* [PostgreSQL](http://www.postgresql.org/), as database
* [UnrealIRCd](https://www.unrealircd.org/), as IRC server daemon, with:
  * [Anope](https://www.anope.org/), as IRC services daemon
* Soon: [Let's Encrypt](https://letsencrypt.org/), as SSL certificate generator
* Soon: [Varnish](http://varnish-cache.org/), as static files cache
