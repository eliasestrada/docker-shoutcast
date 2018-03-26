# docker-shoutcast
Minimal SHOUTcast server

![](https://upload.wikimedia.org/wikipedia/en/thumb/f/f7/SHOUTcast_logo.svg/200px-SHOUTcast_logo.svg.png)

[SHOUTcast](http://wiki.shoutcast.com/wiki/SHOUTcast) Server (DNAS) - The most popular online streaming server
software on the planet, used by over 50,000 broadcasters.

## How it works

```
+-----+       +-----------+
| mpd | ----> | shoutcast |
+-----+  PUB  +-----------+
                    ^
                    |SUB
           +--------+--------+
           |        |        |
        +-----+  +-----+  +-----+
        | mpd |  | mpd |  | mpd |
        +-----+  +-----+  +-----+
```

## docker-compose.yml

Server:

```yaml
shoutcast:
  image: riftbit/shoutcast
  ports:
    - "8000:8000"
    - "8001:8001"
  volumes:
    - ./sc_serv.conf:/opt/shoutcast/sc_serv.conf
    - ./logs:/opt/shoutcast/logs
  restart: always
```

## sc_serv.conf

```ini
#
# http://wiki.shoutcast.com/wiki/SHOUTcast_DNAS_Server_2
#

password=sourcepass
adminpassword=admpass
requirestreamconfigs=1
logfile=logs/sc_serv.log
w3clog=logs/sc_w3c.log
banfile=control/sc_serv.ban
ripfile=control/sc_serv.rip

streamid_1=1
streampath_1=/mountpoint1
streammaxuser_1=20
streampassword_1=password
streamadminpassword_1=admpasswd

streamid_2=2
streampath_2=/mountpoint2
streammaxuser_2=25
streampassword_2=password2
streamadminpassword_2=admpasswd2
```

## nginx.conf

```
http {
    server {
        listen 80;
        server_name shoutcast.info;
        location / {
            proxy_pass http://127.0.0.1:8000;
        }
    }
}

stream {
    server {
        listen 81;
        proxy_pass 127.0.0.1:8001;
    }
}
```

Based on vimagick/dockerfiles but smaller
