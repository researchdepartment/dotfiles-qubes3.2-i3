#!/usr/bin/env bash
if [ $# -eq 1 ]
then
	echo "usage: encrypt-vm-container.sh examplevm 10GB"
	exit
fi
vm=$1
size=$2
file=/var/lib/qubes/appvms/$vm
if [ -d $file ]; then
	echo "shutting down $vm"
	qvm-shutdown --wait $vm
	echo "$vm has been shut down"
	echo "temporarily moving $vm/ to enc-$vm/"
	mv /var/lib/qubes/appvms/$vm /var/lib/qubes/appvms/enc-$vm
	echo "allocating $size to $vm"
	fallocate -l $size /var/lib/qubes/appvms/$vm.img
	echo "setting up encrypted container for $vm ($vm.img)"
	sudo cryptsetup luksFormat /var/lib/qubes/appvms/$vm.img
	sudo cryptsetup luksOpen /var/lib/qubes/appvms/$vm.img enc-$vm
	echo "setting ext4 filesystem for $vm"
	sudo mkfs -t ext4 /dev/mapper/enc-$vm
	mkdir /var/lib/qubes/appvms/$vm
	sudo mount /dev/mapper/enc-$vm /var/lib/qubes/appvms/$vm
	sudo chown -R $USER:$USER /var/lib/qubes/appvms/$vm
	echo "copying from enc-$vm/ to $vm/"
	sudo cp -fr /var/lib/qubes/appvms/enc-$vm/* /var/lib/qubes/appvms/$vm
	echo "done!"
	sudo umount /var/lib/qubes/appvms/$vm
	sudo cryptsetup luksClose enc-$vm
	echo "Mount: sh Qubes/mount/unlock-vm-container.sh $vm"
	echo "Then try starting the VM in Qubes VM Manager."
	echo "Note: 'rm -r /var/lib/qubes/appvms/enc-$vm/' if everything works!"
else
	echo "$vm doesn't exist"
fi
