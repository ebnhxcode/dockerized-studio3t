FROM ubuntu:18.04
MAINTAINER Esteban Ramos <eramos@digital.gob.cl>

ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root

# Instalo dependencias necesarias
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
	supervisor \ 
    openssh-server wget pwgen sudo vim-tiny \
    libxext-dev libxrender-dev libxtst-dev software-properties-common \
    net-tools \
    lxde x11vnc xvfb \
    ttf-ubuntu-font-family \
    firefox \
    nginx \
    curl \
    dirmngr gpg-agent \
    python-pip python-dev build-essential && \
    apt-get autoclean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*


# Instalo repos y mongo
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5 \ 
    && echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.6.list 
RUN apt-get install -y apt-transport-https && apt-get update \
    && apt-get install -y mongodb-org-shell mongodb-org-tools



# Descargo el software a usar
ENV STUDIO3T_URL=https://download.studio3t.com/studio-3t/linux/2019.7.1/studio-3t-linux-x64.tar.gz
RUN wget --progress=bar:force $STUDIO3T_URL -O /tmp/studio-3t-linux-x64.tar.gz \
        && mkdir /opt/studio3t \
        && tar -xvzf /tmp/studio-3t-linux-x64.tar.gz -C /opt/studio3t --strip-components=1 \
        && tar -zxvf /tmp/studio-3t-*.tar.gz

# Configuro usuario permisos y supervisor
ADD bin/startup.sh /
ADD conf.d/supervisord.conf /etc/supervisor/conf.d/

EXPOSE 5900
WORKDIR /root
ENTRYPOINT ["/startup.sh"]
