#!/usr/bin/env bash
if [ $# -eq 0 ]
then
	echo "usage: restore-vm-nocontainer.sh vmname"
	exit
fi
vm=$1
file=/var/lib/qubes/appvms/$vm.img
if [ -f $file ]; then
	echo "removing $vm.img"
	sudo rm -r $file
	echo "moving appvms/enc-$vm to appvms/$vm"
	mv /var/lib/qubes/appvms/enc-$vm /var/lib/qubes/appvms/$vm
	echo "done"
else
	echo "$vm doesn't exist"
fi
