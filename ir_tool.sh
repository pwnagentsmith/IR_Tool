#!/bin/bash

# ------------------------------------------------------------
# -- Setup parameters
# ------------------------------------------------------------

if [ -z $1 ]; then
	echo "usage: $0 <dir_name>"
	exit;
fi
base_dir=$1
mkdir -p $base_dir
env_file="$base_dir/env_info.txt"
null_file="$base_dir/null_info.txt"
shell_file="$base_dir/shell_info.txt"
system_file="$base_dir/system_info.txt"
history_file="$base_dir/history_info.txt"
crontab_file="$base_dir/crontab_info.txt"
process_file="$base_dir/process_info.txt"
network_file="$base_dir/network_service.txt"
network_config="$base_dir/network_config.txt"
install_file_info="$base_dir/install_file.txt"
timeline_file="$base_dir/timeline.txt"
malware_file="$base_dir/MALWARE_info.txt"
http_file="$base_dir/HTTP_SERVER_info.txt"
abnormal_file="$base_dir/NOUSER_NOGROUP_info.txt"

# ------------------------------------------------------------
# -- Start the procedure
# ------------------------------------------------------------

# Save the command history, if existed
echo "[COMMAND HISTORY LIST]" >> $history_file 
export HISTTIMEFORMAT='%F %T '
history -w
history >> $history_file


# Fetch environment variables
echo "[ENVIRONMENT VARIABLES]" >> $env_file
env >> $env_file
echo -e "\n" >> $env_file
echo "[SHELL VARIABLES]" >> $env_file
set >> $env_file


# Fetch shell config file
echo "[SHELL]" >> $shell_file
echo -e "\n" >> $shell_file

# /etc/profile
if [ -e "/etc/profile" ] ; then
    echo "[/etc/profile]" >> $shell_file
    cat /etc/profile >> $shell_file
    echo -e "\n" >> $shell_file
fi

# /root/.bash_profile
if [ -e "/root/.bash_profile" ] ; then
    echo "[/root/.bash_profile]" >> $shell_file
    cat ~/.bash_profile >> $shell_file
    echo -e "\n" >> $shell_file
fi

# /root/.bash_login
if [ -e "/root/.bash_login" ] ; then
    echo "[/root/.bash_login]" >> $shell_file
    cat ~/.bash_login >> $shell_file
    echo -e "\n" >> $shell_file
fi

# /root/.profile
if [ -e "/root/.profile" ] ; then
    echo "[/root/.profile]" >> $shell_file
    cat /root/.profile >> $shell_file
    echo -e "\n" >> $shell_file
fi

# /root/.bashrc
if [ -e "/root/.bashrc" ] ; then
    echo "[/root/.bashrc]" >> $shell_file
    cat /root/.bashrc >> $shell_file
    echo -e "\n" >> $shell_file
fi

# /root/.bash_logout
if [ -e "/root/.bash_logout" ] ; then
    echo "[/root/.bash_logout]" >> $shell_file
    cat /root/.bash_logout >> $shell_file
    echo -e "\n" >> $shell_file
fi

# Fetch default information

# time information
echo "[BIOS TIME]" >> $system_file 
hwclock -r >> $system_file 
echo -e "\n" >> $system_file
echo "[SYSTEM TIME]" >> $system_file
date >> $system_file
echo -e "\n" >> $system_file

# system information
echo "[KERNEL INFO]" >> $system_file
uname -a >> $system_file
echo -e "\n" >> $system_file

# user information
echo "[USER INFO]" >> $system_file
w >> $system_file
echo -e "\n" >> $system_file

# privilege information
echo "[PRIVLEGE]" >> $system_file
cat /etc/passwd >> $system_file
echo -e "\n" >> $system_file

#last information
echo "[CURRENT USER LAST LOGIN]" >> $system_file
whoami >> $user_file
echo -e "\n" >> $system_file
last >> $user_file
echo -e "\n" >> $system_file

#lastlog information
echo "[USERS LAST LOGIN]" >> $system_file
lastlog >> $user_file
echo -e "\n" >> $system_file

# privilege information
echo "[SUDO USERS]" >> $system_file
cat /etc/sudoers >> $system_file
echo -e "\n" >> $system_file

# Fetch NULL Info
lsof -w /dev/null >> $null_file


#  Fetch crontab records
crontab -l >> $crontab_file 2>/dev/null


# Fetch process information

# ps -l (ROOT)
echo "[PROCESS ROOT]" >> $process_file
ps -l >> $process_file
echo -e "\n" >> $process_file

# ps aux (ALL)
echo "[PROCESS ALL]" >> $process_file
ps aux >> $process_file
echo -e "\n" >> $process_file

# pstree
echo "[PROCESS TREE]" >> $process_file
pstree -Aup >> $process_file
echo -e "\n" >> $process_file


# Fetch network config

# ifconfig
echo "[Network Config]" >> $network_config
ifconfig >> $network_config
echo -e "\n" >> $network_config

# interface
echo "[Network Interface]" >> $network_config
cat /etc/network/interfaces >> $network_config
echo -e "\n" >> $network_config

# DNS
echo "[Network DNS]" >> $network_config
cat /etc/resolv.conf >> $network_config
echo -e "\n" >> $network_config

# hostname
echo "[Network Hosts]" >> $network_config
cat /etc/hosts >> $network_config
echo -e "\n" >> $network_config
echo "[Network Hostname]" >> $network_config
cat /etc/hostname >> $network_config
echo -e "\n" >> $network_config


# Fetch network services

# services
echo "[Network Services]" >> $network_file
netstat -anp >> $network_file
echo -e "\n" >> $network_file

# connection
echo "[Network Connection]" >> $network_file
lsof -i >> $network_file
echo -e "\n" >> $network_file

# process
echo "[Network with Process]" >> $network_file
netstat -anp >> $network_file
echo -e "\n" >> $network_file


# HTTP server inforamtion collection

# Nginx collection
echo "[Nginx Info]" >> $http_file
find / -name 'nginx' >> $http_file
echo -e "\n" >> $http_file
# tar default directory
if [ -e "/usr/local/nginx" ] ; then
    tar -zc -f HTTP_SERVER_DIR_nginx.tar.gz /usr/local/nginx 2>/dev/null
fi

# Apache2 collection
echo "[Apache Info]" >> $http_file
find / -name 'apache2' >> $http_file
echo -e "\n" >> $http_file
# tar default directory
if [ -e "/etc/apache2" ] ; then
    tar -zc -f HTTP_SERVER_DIR_apache.tar.gz /etc/apache2 2>/dev/null
fi


# Malware collection
# .bin
echo "[BIN FILETYPE]" >> $malware_file
find / -name \*.bin >> $malware_file
echo -e "\n" >> $malware_file

# .exe
echo "[BIN FILETYPE]" >> $malware_file
find / -name \*.exe >> $malware_file
echo -e "\n" >> $malware_file


# Find nouser or nogroup  data
echo "[NOUSER]" >> $abnormal_file
find / -nouser >> $abnormal_file
echo -e "\n" >> $abnormal_file

echo "[NOGROUP]" >> $abnormal_file
find / -nogroup >> $abnormal_file
echo -e "\n" >> $abnormal_file

# Install files
echo "[lsmod]" >> $install_file_info.txt
lsmod >> $install_file_info.txt
echo -e "\n" >> $install_file_info.txt

# File tiimeline
find / -type f -printf "%P,%A+,%T+,%C+,%u,%g,%M,%s\n" >> $timeline_file


# Package files

# /var/log/
tar -zc -f $base_dir/VAR_LOG.tar.gz /var/log/ 2>/dev/null

# /root/
tar -zc -f $base_dir/ROOT_HOME.tar.gz /root/ 2>/dev/null

# /home/
for name in $(ls /home)
do
    tar -zc -f $base_dir/HOME_$name.tar.gz /home/$name 2>/dev/null
done
