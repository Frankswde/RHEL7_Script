#!/bin/bash
#===========================================
# Author  : Frank  at 2020-05-21
# for : Yum_Base_from_DVD 
#===========================================

# Mount DVD

mount /dev/sr0 /mnt

# cope repo

cp ./rhel7dvd.repo /etc/yum.repos.d/rhel7dvd.repo

# clean Yum cash

yum clean all
subscription-manager clean

# Install Base page from DVD

yum install -y audispd-plugins bzip2 lvm2 man-pages man-pages-overrides ncurses-term ntpdate openssh-clients rsync rsyslog-gnutls rsyslog-gssapi rsyslog-relp smartmontools tcsh unzip vim-enhanced which zip zsh ftp lftp finger ncompress tcp_wrappers telnet xinetd iptraf nmap aide vsftpd crypto-utils tree unixODBC-devel setroubleshoot sysstat net-snmp net-snmp-utils bind-utils traceroute iptables-services mysql-connector-odbc mysql-connector-java ant openssl openssl-devel mysql-devel net-tools psmisc perl-CPAN kernel-devel gcc perl-Authen-SASL perl-IO-Socket-IP perl-Digest-SHA1

# Install Develop page from DVD

yum install -y gcc compat-gcc-44 compat-gcc-44-c++ expect gcc-objc++ libstdc++-docs

# system Reboot

reboot