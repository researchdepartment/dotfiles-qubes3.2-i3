# Set up a Fedora 23 build-VM
## dom0: 
sudo qubes-dom0-update --enablerepo=qubes-templates-itl qubes-template-fedora-23-minimal
## sys-build-f23
## fedora-23-minimal + appvm (standalone) + sys-net + grey
su root
dnf install -y git sudo xorg-x11-font-utils wget nano
sudo dnf groupinstall -y "Development Tools" "Development Libraries"
exit
## dom0:
qvm-copy-to-vm sys-build-f23 BUILD ## Copy it to sys-build-f23 for easy copy-paste in build-vm (cat QubesIncoming/dom0/BUILD)


# Get numix-gtk-theme and numix-icon-theme
## sys-build-f23
wget https://copr-be.cloud.fedoraproject.org/results/numix/numix/fedora-23-x86_64/00175934-numix/numix-gtk-theme-1010-6.git101307f.fc23.noarch.rpm -O numix-gtk.rpm
wget https://copr-be.cloud.fedoraproject.org/results/numix/numix/fedora-23-x86_64/00175934-numix/numix-icon-theme-1010-6.git101307f.fc23.noarch.rpm -O numix-icon.rpm
wget https://copr-be.cloud.fedoraproject.org/results/numix/numix/fedora-23-x86_64/00175934-numix/numix-icon-theme-circle-1010-6.git101307f.fc23.noarch.rpm -O numix-icon-circle.rpm
## dom0:
qvm-run --pass-io sys-build-f23 'cat /home/user/numix-gtk.rpm' > RPM/numix-gtk.rpm
qvm-run --pass-io sys-build-f23 'cat /home/user/numix-icon.rpm' > RPM/numix-icon.rpm
qvm-run --pass-io sys-build-f23 'cat /home/user/numix-icon-circle.rpm' > RPM/numix-icon-circle.rpm


# Get neofetch
## sys-build-f23:
wget https://raw.githubusercontent.com/dylanaraps/neofetch/master/neofetch
## dom0
qvm-run --pass-io sys-build-f23 'cat /home/user/neofetch' > ../utils/neofetch


# Build lucy-tewi font set
## sys-build-f23
git clone https://github.com/lucy/tewi-font
cd tewi-font
make
mv out/ tewi/
zip -r9 tewi.zip tewi/
## dom0:
qvm-run --pass-io sys-build-f23 'cat /home/user/tewi-font/tewi.zip' > tewi.zip
unzip tewi.zip ../fonts/


# Build i3-gaps-qubes
## sys-build-f23
git clone https://github.com/unendingPattern/i3-gaps-qubes i3-gaps-qubes
wget https://github.com/Airblader/i3/archive/4.12.tar.gz -O i3-gaps-qubes/i3/i3-4.12.tar.gz
gunzip < i3-gaps-qubes/i3/i3-4.12.tar.gz | bzip2 > i3-gaps-qubes/i3/i3-4.12.tar.bz2
cd i3-gaps-qubes
dnf install -y $(cat build-deps.list)
make rpms
## dom0:
qvm-run --pass-io sys-build-f23 'cat /home/user/i3-gaps-qubes/rpm/x86_64/i3-4*.rpm' > dom0/i3-gaps-qubes.rpm
