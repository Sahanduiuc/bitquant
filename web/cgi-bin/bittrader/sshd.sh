#!/bin/bash
# set setuid so that it is run with the user which checked out the
# orginal git

if [ $# -eq 1 ] ; then
export PATH_INFO=$1
else 
echo "Content-type: text/html"
echo ""
fi
echo "<pre>"
if [ "$PATH_INFO" == "/on" ] ; then
sudo systemctl enable sshd 2>&1 
sudo systemctl start sshd 2>&1 
echo "Ssh server enabled"
elif [ "$PATH_INFO" == "/off" ] ; then
sudo systemctl stop sshd 2>&1 
sudo systemctl disable sshd 2>&1 
echo "Ssh server disabled"
else
echo "unknown path $PATH_INFO"
fi

echo "</pre>"