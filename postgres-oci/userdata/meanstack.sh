#!/bin/sh
sudo systemctl stop firewalld
sudo systemctl disable firewalld

#yum install wget –y
wget https://bitnami.com/redirect/to/163961/bitnami-postgresql-10.0-1-linux-x64-installer.run
chmod +x bitnami-postgresql-10.0-1-linux-x64-installer.run
./bitnami-postgresql-10.0-1-linux-x64-installer.run --mode unattended --postgres_port 5432 --postgres_password <PASSWORD> --prefix <PATH TO INSTALL POSTGRESQL>
