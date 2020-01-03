#!/bin/bash

# Requerido si inicio con ssh
mkdir -p /var/run/sshd

# Config usuario y password más cfg de permisos de usuario
MYUSER=ubuntu
MYPASS=123

id -u $MYUSER &>/dev/null || useradd --create-home --shell /bin/bash --user-group --groups adm,sudo $MYUSER
echo "$MYUSER:$MYPASS" | chpasswd

echo "root" | passwd --stdin root

# Supervisor mantiene la X y x11vnc corriendo
exec /usr/bin/supervisord -n