#!/usr/bin/bash
yum -y install mariadb-server mariadb
systemctl start mariadb
systemctl enable mariadb