---
layout: post
title: Redirect Microphone through Remmina RDP
date: 2023-04-09 17:50:01 +1100
categories: 
---

## Issue

Remmina with Linux Mint, 21.2, redirect local microphone to remote computer is not simply a checkbox in Remmina. Moreover, the Audio output mode is not very clear either. Options are Off / Local / Remote

## Solution

The redirection can however be on by entering 1 of the option below in RDB Config/Advanced window.
For the Audio output mode, descriptions can be as below
* turn **Off** (disable) the redirection completely. If there is a speaker connected at remote, nothing will go through it.
* bring the audio to **Local** computer. We will hear whatever is played from remtote.
* leave the audio at **Remote** computer. Well, if there is a speaker connected at remote, sound will be played there.

```
sys:pulse,format:1,quality:high
sys:alsa,format:1,quality:high
```

