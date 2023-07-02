---
layout: post
title: Bridged Network for KVM Guests
date: 2020-07-03 00:10 +1100
categories: note
---

_The content below is taken from https://gist.github.com/plembo/a7b69f92953a76ab2d06533754b5e2bb_

# Setting up a bridged network for KVM guests
This will work with either networkd or NetworkManager as a resolver. In fact, this is the _only_ way to do bridged KVM
(libvirtd) networking with NetworkManager.

If you're using NetworkManager (on a desktop or laptop, for example) on your KVM host, follow [these instructions](https://gist.github.com/plembo/f7abd2d9b6f76e7afdece02dae7e5097) to set up a bridge interface.

## Add a bridge interface to Ubuntu desktop using nmcli
Had to do this for some advanced networking with KVM, and couldn't figure out how to do it using the Nework Manager gui.
Did find an article later that showed how to do it with nmtui, but it's so much easier to record what you did when using
the cli.

Note: I now set ```net.ifnames=0``` in grub for all my machines, to ensure my device names are "predictable" (so the first ethernet device will be "eth0" and not "ens1", "eno1 or anything else).

To see what everything looks like before starting:

```
$ nmcli con show
```
I renamed "Wired Connection 1' to the name of my physical interface:

```
$ sudo nmcli con mod 'Wired Connection 1' con-name eth0
```
So let's start out by creating the bridge itself:

```
$ nmcli con add ifname br0 type bridge con-name br0
```
Now add the physical interface as its slave:

```
$ nmcli con add type bridge-slave ifname ens3 master br0
```
Disable STP:

```
$ nmcli con mod br0 bridge.stp no
```
Now down the physical interface:

```
$ nmcli con down eth0
```
For this machine I want a static address:
```
$ nmcli con mod br0 ipv4.addresses 10.1.1.16/24
$ nmcli con mod br0 ipv4.gateway 10.1.1.1
$ nmcli con mod br0 ipv4.dns '10.1.1.1,8.8.8.8,8.8.4.4'
```
Don't forget to set your search domain:
```
$ nmcli con mod br0 ipv4.dns-search 'example.com'
```
Finally tell Network Manager this will be a manual connection:
```
nmcli con mod br0 ipv4.method manual
```
Finally, bring up the new bridge interface:
```
nmcli con up br0
```
Run ```nmcli device show``` to confirm your changes, and then restart NetworkManager (```sudo systemctl restart NetworkManager.service```)
to make sure the configuration sticks.

## Setting up a bridged network for KVM guests
Once you have the host bridge set up, proceed as follows:

1. Create a bridge network device inside KVM. Edit and save the below text as file host-bridge.xml:
```xml
<network>
   <name>host-bridge</name>
   <forward mode="bridge"/>
   <bridge name="br0"/>
</network>
```
Then execute these commands (as a user in the libvirt group):

```bash
$ virsh net-define host-bridge.xml
$ virsh net-start host-bridge
$ virsh net-autostart host-bridge
```
2. Make it possible for hosts outside of KVM to talk to your bridged guest by making the following changes on the KVM host.

Load the br_netfilter module:
```bash
$ sudo modprobe br_netfilter
```

Persist on reboot by creating /etc/modules-load.d/br_netfilter.conf:
```bash
$ sudo echo "br_netfilter" > /etc/modules-load.d/br_netfilter.conf
```

Create /etc/sysctl.d/10-bridge.conf:
```bash
# Do not filter packets crossing a bridge
net.bridge.bridge-nf-call-ip6tables=0
net.bridge.bridge-nf-call-iptables=0
net.bridge.bridge-nf-call-arptables=0
```

Apply the config now:
```bash
$ sudo sysctl -p /etc/sysctl.d/10-bridge.conf
```

Check result:
```bash
$ sudo sysctl -a | grep "bridge-nf-call"
```

3. Configure the guest to use host-bridge.
Open up the Virtual Machine Manager and then select the target guest. Go to the NIC device. The drop down for
"Network Source" should now include a device called "Virtual netowrk 'host-bridge'". The "Bridge network device
model" will be "virtio" if that's your KVM configuration's default.

Select that "host-bridge" device.

If you inspect the guest's XML (by using ```virsh dumplxml guestname```), it shoud look something like this:

```xml
<interface type='network'>
   <mac address='52:54:8b:d9:bf:a2'/>
   <source network='host-bridge'/>
   <model type='virtio'/>
   <address type='pci' domain='0x0000' bus='0x00' slot='0x03' function='0x0'/>
</interface>'
```
Be sure to save your changes!

4. Go up to your router and add a DHCP reservation and DNS mapping for the guest (assuming you want a dynamic address and
want to be able to easily find the guest later). Otherwise, be prepared to manually configure networking on the guest.

5. Start (or restart) the guest.
