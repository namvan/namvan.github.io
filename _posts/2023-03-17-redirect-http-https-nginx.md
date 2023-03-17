---
layout: post
title: Redirect HTTP to HTTPS in nginx
date: 2023-03-17 19:01:01 +1100
categories: 
---

## Intro

It is a common task to redirect any http traffic to https after SSL is enabled for a site. A server block can be used to achive this task.

## Redirect all HTTP

This configuration will catch alll traffic on port 80, which is for http, and redirect them to port 443 which is for https.  
This will work best when all configured sites should use https.  
The server block will look like this.  

```
server {
  listen 80 default_server;
  server_name _;
  return 301 https://$host$request_uri;
}
```
Explanation:  
* This config will listen on port 80 for traffic.
* The server_name is set as _ to match any hostname.
* The return 301 will do the job.

## Redirect for a specific site

The server block will look like this

```
server {
  listen 80;
  server_name asite.com;
  return 301 https://asite.com$request_uri;
}
```
## The HTTPS block

The config block for https will look like this

```
server {
  listen 443 ssl default_server;
  server_name asite.com;
}
server {
  listen 443 ssl;
  server_name bsite.com;
}
```

