---
layout: post
title: Check Linux Mint Version
date: 2023-04-12 15:32:01 +1100
categories: 
---

Linux Mint XFCE crashed and then started to look.... weird.
See more here https://easylinuxtipsproject.blogspot.com/p/bugs.html#ID21

There are a couple of options to try.

a. First the action with the least impact, namely a restart of the window manager.

- Launch a terminal window.
(You can launch a terminal window like this: *Click*)

- Copy/paste the following line into the terminal, to avoid errors:

xfwm4 --replace

Press Enter.

b. Disable all visual effects. In Linux Mint, even lightweight champion Xfce has some relatively heavy visual effects by default. Disable them like this:

Menu button - Settings - Desktop Settings
Window Manager: set it to plain Xfwm4 (instead of Xfwm4 + Compositing)

Then remove Compiz:

Launch a terminal window.
(You can launch a terminal window like this: *Click*)

Type (use copy/paste to prevent errors):

sudo apt-get remove compiz-core

Press Enter. Type your password when prompted. In Ubuntu this remains entirely invisible, not even dots will show when you type it, that's normal. In Mint this has changed: you'll see asterisks when you type. Press Enter again.

c. If all that doesn't help, reset your Xfce desktop to its default settings as follows:

- Copy/paste the following line into the terminal:

rm -r -v ~/.config/xfce4

Press Enter.

- For the new settings to take effect, log out and log in again.