define Device/FitImage
	KERNEL_SUFFIX := -uImage.itb
	KERNEL = kernel-bin | gzip | fit gzip $$(KDIR)/image-$$(DEVICE_DTS).dtb
	KERNEL_NAME := Image
endef

define Device/FitImageLzma
	KERNEL_SUFFIX := -uImage.itb
	KERNEL = kernel-bin | lzma | fit lzma $$(KDIR)/image-$$(DEVICE_DTS).dtb
	KERNEL_NAME := Image
endef

define Device/UbiFit
	KERNEL_IN_UBI := 1
	IMAGES := factory.ubi sysupgrade.bin
	IMAGE/factory.ubi := append-ubi
	IMAGE/sysupgrade.bin := sysupgrade-tar | append-metadata
endef

define Device/dynalink_dl-wrx36
	$(call Device/FitImage)
	$(call Device/UbiFit)
	DEVICE_VENDOR := Dynalink
	DEVICE_MODEL := DL-WRX36
	BLOCKSIZE := 128k
	PAGESIZE := 2048
	DEVICE_DTS_CONFIG := config@rt5010w-d350-rev0
	SOC := ipq8072
	DEVICE_PACKAGES := ipq-wifi-dynalink_dl-wrx36
endef
TARGET_DEVICES += dynalink_dl-wrx36

define Device/edgecore_eap102
	$(call Device/FitImage)
	$(call Device/UbiFit)
	DEVICE_VENDOR := Edgecore
	DEVICE_MODEL := EAP102
	BLOCKSIZE := 128k
	PAGESIZE := 2048
	DEVICE_DTS_CONFIG := config@ac02
	SOC := ipq8071
	DEVICE_PACKAGES := ipq-wifi-edgecore_eap102
	IMAGE/factory.ubi := append-ubi | qsdk-ipq-factory-nand
endef
TARGET_DEVICES += edgecore_eap102

define Device/edimax_cax1800
	$(call Device/FitImage)
	$(call Device/UbiFit)
	DEVICE_VENDOR := Edimax
	DEVICE_MODEL := CAX1800
	BLOCKSIZE := 128k
	PAGESIZE := 2048
	DEVICE_DTS_CONFIG := config@ac03
	SOC := ipq8070
	DEVICE_PACKAGES := ipq-wifi-edimax_cax1800
endef
TARGET_DEVICES += edimax_cax1800

define Device/qnap_301w
	$(call Device/FitImage)
	DEVICE_VENDOR := QNAP
	DEVICE_MODEL := 301w
	DEVICE_DTS_CONFIG := config@hk01
	KERNEL_SIZE := 16384k
	BLOCKSIZE := 512k
	SOC := ipq8072
	IMAGES += factory.bin sysupgrade.bin
	IMAGE/factory.bin := append-rootfs | pad-rootfs | pad-to 64k
	IMAGE/sysupgrade.bin/squashfs := append-rootfs | pad-to 64k | sysupgrade-tar rootfs=$$$$@ | append-metadata
	DEVICE_PACKAGES := ipq-wifi-qnap_301w e2fsprogs kmod-fs-ext4 losetup
endef
TARGET_DEVICES += qnap_301w

define Device/redmi_ax6
	$(call Device/xiaomi_ax3600)
	DEVICE_VENDOR := Redmi
	DEVICE_MODEL := AX6
	DEVICE_PACKAGES := ipq-wifi-redmi_ax6
endef
TARGET_DEVICES += redmi_ax6

define Device/xiaomi_ax3600
	$(call Device/FitImage)
	$(call Device/UbiFit)
	DEVICE_VENDOR := Xiaomi
	DEVICE_MODEL := AX3600
	BLOCKSIZE := 128k
	PAGESIZE := 2048
	DEVICE_DTS_CONFIG := config@ac04
	SOC := ipq8071
	DEVICE_PACKAGES := ipq-wifi-xiaomi_ax3600 kmod-ath10k-ct-smallbuffers ath10k-firmware-qca9887-ct
endef
TARGET_DEVICES += xiaomi_ax3600

define Device/xiaomi_ax9000
	$(call Device/FitImage)
	$(call Device/UbiFit)
	DEVICE_VENDOR := Xiaomi
	DEVICE_MODEL := AX9000
	BLOCKSIZE := 128k
	PAGESIZE := 2048
	DEVICE_DTS_CONFIG := config@hk14
	SOC := ipq8072
	DEVICE_PACKAGES := ipq-wifi-xiaomi_ax9000 kmod-ath11k-pci ath11k-firmware-qcn9074 \
	kmod-ath10k-ct ath10k-firmware-qca9887-ct
endef
TARGET_DEVICES += xiaomi_ax9000

define Device/zyxel_nbg7815
	$(call Device/FitImage)
	DEVICE_VENDOR := ZYXEL
	DEVICE_MODEL := NBG7815
	DEVICE_DTS_CONFIG := config@nbg7815
	BLOCKSIZE := 128k
	PAGESIZE := 2048
	SOC := ipq8074
	IMAGES += factory.bin sysupgrade.bin
	IMAGE/factory.bin := append-rootfs | pad-rootfs | pad-to 64k
	IMAGE/sysupgrade.bin/squashfs := append-rootfs | pad-to 64k | sysupgrade-tar rootfs=$$$$@ | append-metadata
	DEVICE_PACKAGES := ipq-wifi-zyxel_nbg7815 kmod-ath11k-pci e2fsprogs kmod-fs-ext4 losetup kmod-hwmon-tmp103 \
	kmod-bluetooth kmod-usb-storage kmod-fs-ntfs3
	
endef
TARGET_DEVICES += zyxel_nbg7815
