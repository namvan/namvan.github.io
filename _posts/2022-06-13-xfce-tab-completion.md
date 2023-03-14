---
layout: post
date:   2022-06-13 01:01:01 +1100
categories: 
---

Debian, Xfce, Terminal without Tab completion from xrdp session
original link here https://ubuntuforums.org/archive/index.php/t-1771058.html

edit
~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml

find the line 

    <property name="&lt;Super&gt;Tab" type="string" value="switch_window_key"/>

and change it to 

    <property name="&lt;Super&gt;Tab" type="empty"/>