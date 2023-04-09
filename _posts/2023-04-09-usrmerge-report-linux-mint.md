---
layout: post
title: usrmerge report persisted with Linux Mint
date: 2023-04-09 14:50:01 +1100
categories: 
---

## Issue

With Linux Mint upgraded to 21.2 or even when on 20.x, the usrmerge report kept popping up. Doing as suggesting in the report with apt install did not make it disappear. Removing it then reinstalling won't make any difference either.

## Solution

Dig... and dig... and dig... and dig till came across this https://forums.linuxmint.com/viewtopic.php?t=371158

The reason is quite simple. There are a few links to be done as below

```
bin -> usr/bin
lib -> usr/lib
lib64 -> usr/lib64
libx32 -> usr/libx32
sbin -> usr/sbin
```

However one is not there. One of the links, in this case lib32 can not be established becase the folder is not available from root path on this system. It might be from the fact that no 32 bit libraries were ever installed. The fix is then aslo simple, just create the link manually so that it might be used one day.

```
sudo ln -s usr/lib32 /lib32
```

