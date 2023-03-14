When hosting ASP.NET MVC in IIS behind NGINX reverse proxy, there is a problem with redirection for sub folder. For example the redirection is something as below will fail at some point

http://mysite.com/app1 --> 192.168.0.13:8088

The problem is describe here <https://stackoverflow.com/questions/51522474/asp-net-mvc-behind-nginx-reverse-proxy?rq=1>

And there are 2 options to overcome it which is in the above link.

Here is another link for some more details <https://www.billbogaiv.com/posts/net-core-hosted-on-subdirectories-in-nginx>

<https://stackoverflow.com/questions/13240840/nginx-reverse-proxy-multiple-backends/13241047>

````
server { 
    server_name client.domain.com;

    location / {
        # app1 reverse proxy follow
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_pass http://x.x.x.100:80;
    }
}

server { 
    server_name client2.domain.com;

    location / {
        # app2 reverse proxy settings follow
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_pass http://x.x.x.101:80;
    }
}
````

<https://www.garron.me/en/linux/nginx-reverse-proxy.html>
````
server {
    listen 80 default_server;
    listen [::]:80 default_server ipv6only=on;

    root /usr/share/nginx/html;
    index index.html index.htm;

    server_name www.example.com;

    location / {
        try_files $uri $uri/ =404;
    }

    location /wordpress/ {
       proxy_set_header X-Real-IP  $remote_addr;
       proxy_set_header X-Forwarded-For $remote_addr;
       proxy_set_header Host $host;
       proxy_pass http://192.168.1.2:8080;
       }

    location /photoblog/ {
       proxy_set_header X-Real-IP  $remote_addr;
       proxy_set_header X-Forwarded-For $remote_addr;
       proxy_set_header Host $host;
       proxy_pass http://192.168.1.3:8080;
    }

       location /forum/ {
       proxy_set_header X-Real-IP  $remote_addr;
       proxy_set_header X-Forwarded-For $remote_addr;
       proxy_set_header Host $host;
       proxy_pass http://192.168.1.4:8080;
       }
}
````
or this <https://askubuntu.com/questions/766352/multiple-websites-on-nginx-one-ip>
