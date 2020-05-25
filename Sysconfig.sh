#!/bin/bash
#===========================================
# Author  : Frank  at 2020-05-22
# for : Yum_Base_from_DVD 
#===========================================


print_line() {
	printf "%$(tput cols)s\n"|tr ' ' '-'
}

print_title() {
	clear
	print_line
	echo -e "# ${Bold}$1${Reset}"
	print_line
	echo ""
}


# Install MariaDB from DVD
add_MariaDB() {
	print_title " Install 
 	yum install -y mariadb-server mariadb-devel mariadb-libs
	systemctl enable mariadb
	systemctl start mariadb
	mysqladmin -u root password 80268351


}

# 更新本地域名
configure_hostname(){
	print_title "configure_hostname"
	read -p "Hostname [ex: DCC-TEST-177]: " HOSTname
	hostnamectl set-hostname HOSTname
}
# 更新本地使用者
configure_username(){
        print_title "configure_username"
        useradd airlink 
	passwd airlink
	useradd -u9999 admin 
	passwd admin 
	useradd -u9998 op 
	passwd op
        sed -i 's/\# \%wheel ALL=(ALL) ALL/\%wheel ALL=(ALL) ALL/g' /etc/sudoers
	sed -i 's/\# \%wheel admin ALL=(ALL) ALL ' /etc/sudoers
	sed -i 's/\# \%wheel op ALL=(ALL) ALL  ' /etc/sudoers
}


# 設定系統通用參數
configure_system(){
	print_title "configure_system"
	ntpdate 192.168.0.97
}

add_MariaDB
configure_hostname
configure_system
configure_username
