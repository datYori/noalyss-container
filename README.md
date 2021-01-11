# [Noalyss](https://www.noalyss.eu/) in Docker

Basic Dockerfile to run Noalyss inside a container

## TO DO

- [ ] split this big ball of mud into multiple containers
- [ ] basic docker-compose file
- [ ] be nomad ready
- [ ] be kube ready
- [ ] apache orchestration (supress AH00558 warning) (```echo "ServerName $(ip route get 8.8.8.8 | awk '{print $NF; exit}')" >> /etc/apache2/apache2.conf```)


## BUID IT, RUN IT, FIX IT

```bash
#Build it
docker build . -t noalyss:7410 --build-arg DEBIAN_VERSION=buster
#Run it
docker run -p 49200:80 -u 0 noalyss:7410
# If you get DB connexion problem during installation
## Get into it
 docker exec -it $(docker ps -f ancestor=noalyss:7410 -q) bash
### inside the container
root@xxxxxxxxxxx:/$ /etc/init.d/postgresql restart
```
