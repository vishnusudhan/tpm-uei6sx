FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# HAB Features
SRC_URI += "file://0001-Enable-secure-boot-support.patch"

# Fastboot for UUU tool
SRC_URI += "file://0002-Add-fastboot-support-for-UUU-tool.patch"

# UEI doesn't require U-Boot encrypted, hence disabled by default
# SRC_URI += "file://0003-Enable-encrypted-boot-support.patch"

# Added to automate encryption & fuse read with UUU tool
SRC_URI += "file://0004-Add-fastboot-commands.patch"

# TEMP: Enable CAAM Driver
SRC_URI += "file://0005-Add-CAAM-driver-support.patch"
