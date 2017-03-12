#version=DEVEL
# System authorization information
auth --enableshadow --passalgo=sha512
# Use network installation
install
#url --url="http://mirror.centos.org/centos/7/os/x86_64"
# Use cdrom installation
cdrom
# Use graphical install
# graphical
# Use text install
text
# Run the Setup Agent on first boot
firstboot --enable
ignoredisk --only-use=sda
# Keyboard layouts
keyboard --vckeymap=us --xlayouts='us'
# System language
lang en_US.UTF-8

# Network information
network  --bootproto=dhcp --device=eno16777984 --ipv6=auto --activate
network  --hostname=localhost.localdomain

# Root password
rootpw explorer
user --name faktor --groups wheel --password explorer
# System services
services --enabled="chronyd"
# System timezone
timezone Europe/Kiev --isUtc --ntpservers=0.centos.pool.ntp.org,1.centos.pool.ntp.org,2.centos.pool.ntp.org,3.centos.pool.ntp.org
# System bootloader configuration
bootloader --append=" crashkernel=auto" --location=mbr --boot-drive=sda
autopart --type=lvm
# Partition clearing information
clearpart --all --initlabel --drives=sda
eula --agreed
reboot
%packages
@^minimal
@core
chrony
kexec-tools

%end

%addon com_redhat_kdump --enable --reserve-mb='auto'

%end

%post
/usr/bin/yum makecache fast
/usr/bin/yum update -y
/usr/bin/yum install epel-release -y
/usr/bin/yum install yum-utils -y
/usr/bin/yum-config-manager --disablerepo=epel
/usr/bin/yum install expect unzip wget htop vim bash-completion hdparm open-vm-tools git -y

%end
