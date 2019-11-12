#!/usr/bin/env bash
# This block defines the variables the user of the script needs to input
# when deploying using this script.
#
#
#<UDF name="hostname" label="The hostname for the new Linode.">
# HOSTNAME=
#
#<UDF name="fqdn" label="The new Linode's Fully Qualified Domain Name">
# FQDN=

# This sets the variable $IPADDR to the IP address the new Linode receives.
IPADDR=$(/sbin/ifconfig eth0 | awk '/inet / { print $2 }' | sed 's/addr://')

# This updates the packages on the system from the distribution repositories.
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y autoremove

# This section sets the hostname.
echo $HOSTNAME > /etc/hostname
hostname -F /etc/hostname

# This section sets the Fully Qualified Domain Name (FQDN) in the hosts file.
echo $IPADDR $FQDN $HOSTNAME >> /etc/hosts

# Install all essental tools
# source essental_stacks.txt
# source web_stacks.txt
# source dev_stacks.txt
echo "Installing all the essential tools"
cat << stack_option
essental_stacks
web_stacks
dev_stacks
stack_option
read stack_option

echo "Input is $stack_option"

# Get the Package List
if [ stack_option == 'essental_stacks' ] ; then
	stack_option=$essential_list
elif [ stack_option == 'web_stacks' ] ; then
	stack_option=$web_stacks
elif [ stack_option == 'dev_stacks' ] ; then
	stack_option=$dev_stacks
else
	echo "Unknown Option"
fi

echo `dpkg-query -l`

# Install all missing packages
for t in "${stack_option}"
do
	# Check missing packages
	dpkg -l | grep -qw package || apt install -y package
done

# # Check if there is already a venv
# if [ ! -f ${repo}/bin/activate ]; then
#     echo "Install Python3 with pip3"
#     sudo apt-get install -y python3-pip python3-venv python3-dev
#     echo "Venv not found! Creating one now."
#     python3 -m venv ${repo}_venv
# fi

# # Activate Venv
# echo "Activate ${repo}_venv"
# source ${repo}_venv/bin/activate
# pip3 install --upgrade pip
# git clone ${repo}
# cat requirements.txt | xargs -n 1 pip install

echo `dpkg-query -l`

# Essental tools
essential_list="
 git-all
 python3-pip
"

# Dev Stack
dev_list="
 mangodb
 docker
 postgres
 ipython
 redis

"

# Web Stack
web_list="
 mariadb-server php-mysql
 nginx
 wordpress
"
