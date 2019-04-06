help:
	@echo for Windows 2016 type make build-windows-2016-virtualbox
	@echo for Windows 10 type make build-windows-10-virtualbox

build-windows-2016-no-windows-update-virtualbox: windows-2016-amd64-no-windows-update-virtualbox.box
build-windows-2016-windows-update-virtualbox: windows-2016-amd64-windows-update-virtualbox.box

build-windows-10-no-windows-update-virtualbox: windows-10-amd64-no-windows-update-virtualbox.box
build-windows-10-windows-update-virtualbox: windows-10-amd64-windows-update-virtualbox.box


windows-2016-amd64-no-windows-update-virtualbox.box: windows-2016/windows-2016-no-windows-update.json windows-2016/autounattend.xml provisioning/*.ps1 drivers
	rm -f $@
	CHECKPOINT_DISABLE=1 PACKER_LOG=1 PACKER_LOG_PATH=windows-2016/windows-2016-amd64-no-windows-update-virtualbox-packer.log \
		packer build -only=windows-2016-amd64-no-windows-update-virtualbox -on-error=abort windows-2016/windows-2016-no-windows-update.json
	@echo BOX successfully built!
	@echo to add to local vagrant install do:
	@echo vagrant box add -f windows-2016-amd64-no-windows-update-virtualbox $@

windows-2016-amd64-windows-update-virtualbox.box: windows-2016/windows-2016-windows-update.json windows-2016/autounattend.xml provisioning/*.ps1 drivers
	rm -f $@
	CHECKPOINT_DISABLE=1 PACKER_LOG=1 PACKER_LOG_PATH=windows-2016/windows-2016-amd64-windows-update-virtualbox-packer.log \
		packer build -only=windows-2016-amd64-windows-update-virtualbox -on-error=abort windows-2016/windows-2016-windows-update.json
	@echo BOX successfully built!
	@echo to add to local vagrant install do:
	@echo vagrant box add -f windows-2016-amd64-windows-update-virtualbox $@




windows-10-amd64-no-windows-update-virtualbox.box: windows-10/windows-10-no-windows-update-virtualbox.json windows-10/autounattend.xml Vagrantfile.template provisioning/*.ps1 drivers
	rm -f $@
	CHECKPOINT_DISABLE=1 PACKER_LOG=1 PACKER_LOG_PATH=windows-10/windows-10-amd64-no-windows-update-virtualbox-packer.log \
		packer build -only=windows-10-amd64-no-windows-update-virtualbox -on-error=abort windows-10/windows-10-no-windows-update-virtualbox.json
	@echo BOX successfully built!
	@echo to add to local vagrant install do:
	@echo vagrant box add -f windows-10-amd64-no-windows-update-virtualbox $@

windows-10-amd64-windows-update-virtualbox.box: windows-10/windows-10-windows-update.json windows-10/autounattend.xml provisioning/*.ps1 drivers
	rm -f $@
	CHECKPOINT_DISABLE=1 PACKER_LOG=1 PACKER_LOG_PATH=windows-10/windows-10-amd64-windows-update-virtualbox-packer.log \
		packer build -only=windows-10-amd64-windows-update-virtualbox -on-error=abort windows-10/windows-10-windows-update.json
	@echo BOX successfully built!
	@echo to add to local vagrant install do:
	@echo vagrant box add -f windows-10-amd64-windows-update-virtualbox $@




drivers:
	rm -rf drivers.tmp
	mkdir -p drivers.tmp
	@# see https://docs.fedoraproject.org/en-US/quick-docs/creating-windows-virtual-machines-using-virtio-drivers/index.html
	wget -P drivers.tmp https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.160-1/virtio-win-0.1.160.iso
	7z x -odrivers.tmp drivers.tmp/virtio-win-*.iso
	7z a drivers.tmp/virtio-2012-r2.zip drivers.tmp/Balloon/2k12R2/amd64 drivers.tmp/vioserial/2k12R2/amd64
	7z a drivers.tmp/virtio-10.zip drivers.tmp/Balloon/w10/amd64
	7z a drivers.tmp/virtio-2016.zip drivers.tmp/Balloon/2k16/amd64
	7z a drivers.tmp/virtio-2019.zip drivers.tmp/Balloon/2k16/amd64
	mv drivers.tmp drivers


