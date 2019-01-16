#!/usr/bin/env bash
if [ $# -eq 0 ]
then
	echo "usage: lock-vm-container.sh vmname"
	exit
fi
vm=$1
file=/var/lib/qubes/appvms/$vm.img
if [ -f $file ]; then
	echo "shutting down $vm"
	qvm-shutdown --wait $vm
	echo "$vm has been shut down"
	echo "unmounting $vm"
	sudo umount /var/lib/qubes/appvms/$vm
	sudo cryptsetup luksClose enc-$vm
	echo "$vm terminated and unmounted."
else
	echo "$vm doesn't exist"
fi
