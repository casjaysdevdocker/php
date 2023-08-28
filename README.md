## 👋 Welcome to php 🚀  

php README  
  
  
## Install my system scripts  

```shell
 sudo bash -c "$(curl -q -LSsf "https://github.com/systemmgr/installer/raw/main/install.sh")"
 sudo systemmgr --config && sudo systemmgr install scripts  
```
  
## Automatic install/update  
  
```shell
dockermgr update php
```
  
## Install and run container
  
```shell
mkdir -p "$HOME/.local/share/srv/docker/php/rootfs"
git clone "https://github.com/dockermgr/php" "$HOME/.local/share/CasjaysDev/dockermgr/php"
cp -Rfva "$HOME/.local/share/CasjaysDev/dockermgr/php/rootfs/." "$HOME/.local/share/srv/docker/php/rootfs/"
docker run -d \
--restart always \
--privileged \
--name casjaysdevdocker-php \
--hostname php \
-e TZ=${TIMEZONE:-America/New_York} \
-v "$HOME/.local/share/srv/docker/casjaysdevdocker-php/rootfs/data:/data:z" \
-v "$HOME/.local/share/srv/docker/casjaysdevdocker-php/rootfs/config:/config:z" \
-p 80:80 \
casjaysdevdocker/php:latest
```
  
## via docker-compose  
  
```yaml
version: "2"
services:
  ProjectName:
    image: casjaysdevdocker/php
    container_name: casjaysdevdocker-php
    environment:
      - TZ=America/New_York
      - HOSTNAME=php
    volumes:
      - "$HOME/.local/share/srv/docker/casjaysdevdocker-php/rootfs/data:/data:z"
      - "$HOME/.local/share/srv/docker/casjaysdevdocker-php/rootfs/config:/config:z"
    ports:
      - 80:80
    restart: always
```
  
## Get source files  
  
```shell
dockermgr download src casjaysdevdocker/php
```
  
OR
  
```shell
git clone "https://github.com/casjaysdevdocker/php" "$HOME/Projects/github/casjaysdevdocker/php"
```
  
## Build container  
  
```shell
cd "$HOME/Projects/github/casjaysdevdocker/php"
buildx 
```
  
## Authors  
  
🤖 casjay: [Github](https://github.com/casjay) 🤖  
⛵ casjaysdevdocker: [Github](https://github.com/casjaysdevdocker) [Docker](https://hub.docker.com/u/casjaysdevdocker) ⛵  
