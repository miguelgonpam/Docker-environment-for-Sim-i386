#!/bin/bash

# Script simple para crear usuarios desde CSV
# Uso: ./crear-usuarios.sh

# Verificar que el CSV existe
set -e

apt update -y
apt install -y openssh-server sudo git nano hexedit file libcapstone-dev gcc
git clone https://github.com/miguelgonpam/Sim-i386-32bit
cd Sim-i386-32bit
bash ./compile.sh
service ssh restart


if [ ! -f "/data/users.csv" ]; then
    echo "ERROR: No se encuentra users.csv"
    exit 1
fi

# Leer el CSV y crear usuarios
while IFS= read -r username; do
    # Saltar líneas vacías
    if [ -z "$username" ]; then
        continue
    fi
    
    # Limpiar el username
    username=$(echo "$username" | tr -d '\r\n')
    
    # Crear usuario
    useradd -m -s /bin/bash "$username"
    
    # Poner contraseña igual al nombre de usuario
    echo "$username:$username" | chpasswd

    mkdir -p /home/"$username"/
    
    # Copiar archivos al home del usuario
    #cp -r /data/bin/* /home/"$username"/bin/
    #cp /data/libc.so.6 /home/"$username"/
    ln -s /opt/cross/result/bin/i386-linux-musl-gcc /home/"$username"/gcc-i386
    ln -s /opt/cross/result/bin/i386-linux-musl-objdump /home/"$username"/objdump-i386
    ln -s /opt/cross/result/bin/i386-linux-musl-readelf /home/"$username"/readelf-i386
    cp ./proc /home/"$username"/proc
    
    # Cambiar ownership
    chown -R "$username":"$username" /home/"$username"/
    
    echo "Usuario $username creado"
    
done < /data/users.csv


exec bash


