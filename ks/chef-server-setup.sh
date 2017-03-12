#!/bin/bash
# Chef server installation and configuration

#Downloading and installing of chef server package
scp mgmt.lan:/chef/chef-server-core* .
yum localinstall chef-server-core* -y

#Hostname of ChefServer
hostnamectl set-hostname chef.lan

#Chef server configuration
chef-server-ctl reconfigure

#Creating of admin user
chef-server-ctl user-create admin Sergei Saenko sergei.saenko@hotmail.com 'explorer' --filename /etc/chef/admin.pem

#Creating of organization
chef-server-ctl org-create lan 'Home Lan' --association_user admin --filename /etc/chef/lan-validator.pem

#Chef Manage installation
chef-server-ctl install chef-manage
chef-server-ctl reconfigure
chef-manage-ctl reconfigure

#Chef Push Jobs installation
chef-server-ctl install opscode-push-jobs-server
chef-server-ctl reconfigure
opscode-push-jobs-server-ctl reconfigure


#Remove string from root's .bashrc
sed -i '/^.*chef-server*./d' /root/.bashrc

#Final message

echo ""
echo ""
echo "ALL DONE!!!"
echo ""
echo ""
