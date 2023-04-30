---
layout: post
title: Check Linux Mint Version
date: 2023-04-12 15:32:01 +1100
categories: 
---

Content was extracted from here https://linuxconfig.org/check-linux-mint-version

## Using Terminal

```
cat /etc/issue
Linux Mint 19.1 Tessa
```

```
hostnamectl 
   Static hostname: linuxconfig
         Icon name: computer-vm
           Chassis: vm
        Machine ID: 82929df7ee394b73b81252fe3b4e5020
           Boot ID: e5ea25b82b234fdcb098c323c78ec740
    Virtualization: oracle
  Operating System: Linux Mint 19.1
            Kernel: Linux 4.15.0-20-generic
      Architecture: x86-64
```

```
cat /etc/linuxmint/info
RELEASE=19.1
CODENAME=tessa
EDITION="Cinnamon"
DESCRIPTION="Linux Mint 19.1 Tessa"
DESKTOP=Gnome
TOOLKIT=GTK
NEW_FEATURES_URL=https://www.linuxmint.com/rel_tessa_cinnamon_whatsnew.php
RELEASE_NOTES_URL=https://www.linuxmint.com/rel_tessa_cinnamon.php
USER_GUIDE_URL=https://www.linuxmint.com/documentation.php
GRUB_TITLE=Linux Mint 19.1 Cinnamon
```