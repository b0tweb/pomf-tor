# pomf-tor
Pomf hosted on Tor for the b0tweb

### Sample docker-compose.yml

```
botweb:
  image: 'x0rz3q/pomf-tor:latest'
  restart: always
  container_name: pomf_tor
  volumes:
    - '/srv/pomf-tor/tor:/var/lib/tor'
    - '/srv/pomf-tor/pwd:/pwd'
```

To generate an entry in the htpasswd simply run
```
htaccess -c /src/pomf-tor/pwd/.htpasswd user1
```

**Strongly recommended to not use user1 as a username**
