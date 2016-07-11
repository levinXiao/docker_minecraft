#        docker run -d -it -v /root/data/minecraft/data:/data -e EULA=TRUE -e VERSION=1.8.1 -e DIFFICULTY=easy -e MODE=survival -e PVP=0 -p 25565:25565 --restart=always --name mc minecraft

#        docker build -t minecraft .

#docker logs -f mc

FROM java:8

MAINTAINER itzg

ENV APT_GET_UPDATE 2016-04-23
RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
  imagemagick \
  lsof \
  nano \
  sudo \
  vim \
  jq \
  && apt-get clean

RUN useradd -M -s /bin/false --uid 1000 minecraft \
  && mkdir /data \
  && mkdir /config \
  && mkdir /mods \
  && mkdir /plugins \
  && chown minecraft:minecraft /data /config /mods /plugins

EXPOSE 25565 25575

ADD http://7xrlqi.com1.z0.glb.clouddn.com/restify_linux_amd64 /usr/local/bin/restify
COPY start.sh /start
COPY start-minecraft.sh /start-minecraft
COPY eula.text /data
COPY mcadmin.jq /usr/share
RUN chmod +x /usr/local/bin/*

VOLUME ["/data","/mods","/config","/plugins"]
COPY server.properties /tmp/server.properties
WORKDIR /data

ENTRYPOINT [ "/start" ]

ENV UID=1000 GID=1000 \
    MOTD="A Minecraft Server Powered by Docker" \
    JVM_OPTS="-Xmx512M -Xms512M" \
    TYPE=VANILLA VERSION=LATEST FORGEVERSION=RECOMMENDED LEVEL=world PVP=true DIFFICULTY=easy \
    LEVEL_TYPE=DEFAULT GENERATOR_SETTINGS= WORLD= MODPACK=
