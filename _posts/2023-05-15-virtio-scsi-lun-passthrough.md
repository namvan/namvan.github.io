---
layout: post
title: Passthrough Physical Disk for EQMU/KVM
date: 2023-05-15 16:42:01 +1100
categories: 
---

According to the post here https://www.reddit.com/r/VFIO/comments/6k5lf8/virtioscsi_lun_passthrough/ it is easy enough to passthrough the whole disk to QEMU/KVM with virtio-scsi. Here is the extract

None of the guides I've read seem to have mentioned this, but passing through raw disks as SCSI LUNs for VirtIO-SCSI not only allows the guest direct access to the disks themselves (rather than the block device), it also improved I/O performance and general system responsiveness, at least for me.

To use it: in virt-manager, when adding whole disks (not partitions or image files), use the "LUN passthrough" option, which corresponds to the device='lun' XML attribute:
```xml
<disk type='block' device='lun'>
```
as an example

```xml
<disk type="block" device="lun">
  <driver name="qemu" type="raw"/>
  <source dev="/dev/disk/by-id/ata-ST4000DM004-2CV104_WFN1H5C8"/>
  <target dev="sdc" bus="scsi"/>
  <address type="drive" controller="0" bus="0" target="0" unit="2"/>
</disk>
```