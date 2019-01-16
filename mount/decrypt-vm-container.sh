#!/usr/bin/env bash
if [ $# -eq 0 ]
then
	echo "usage: decrypt-vm-container.sh examplevm"
	exit
fi
vm=$1
file=/var/lib/qubes/appvms/$vm.img
if [ -f $file ]; then
	echo "copying from $vm/ to dec-$vm/"
	mkdir /var/lib/qubes/appvms/dec-$vm
	sudo cp -fr /var/lib/qubes/appvms/$vm/* /var/lib/qubes/appvms/dec-$vm
	echo "shutting down $vm"
	qvm-shutdown --wait $vm
	echo "$vm has been shut down"
	sudo umount /var/lib/qubes/appvms/$vm
	sudo cryptsetup luksClose enc-$vm
	sudo rm /var/lib/qubes/appvms/$vm.img
	sudo mv /var/lib/qubes/appvms/dec-$vm /var/lib/qubes/appvms/$vm
	sudo chown -R $USER:$USER /var/lib/qubes/appvms/$vm
	echo "done!"
else
	echo "$vm doesn't exist"
fi
