#version=DEVEL
# System authorization information
auth --enableshadow --passalgo=sha512
install
# Use network installation
# url --url="http://mirror.centos.org/centos/7/os/x86_64"
# Use cdrom installation
cdrom
# Use graphical install
# graphical
# Use text install
text
# Run the Setup Agent on first boot
firstboot --enable
ignoredisk --only-use=vda
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
bootloader --append=" crashkernel=auto" --location=mbr --boot-drive=vda
autopart --type=lvm
# Partition clearing information
clearpart --all --initlabel --drives=vda
eula --agreed
%packages
@^minimal
#@compat-libraries
@core
chrony
kexec-tools

%end

%addon com_redhat_kdump --enable --reserve-mb='auto'

%end

%post --nochroot
/usr/bin/yum update -y
/usr/bin/yum install epel-release -y
/usr/bin/yum install htop vim bash-completion hdparm open-vm-tools -y
grubby --update-kernel=ALL --args="console=ttyS0"
reboot
%end
