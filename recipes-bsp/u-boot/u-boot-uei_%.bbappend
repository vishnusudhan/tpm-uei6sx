FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# HAB Features
SRC_URI += "file://0001-Enable-secure-boot-support.patch"
# UEI doesn't require U-Boot encrypted, hence disabled by default
# SRC_URI += "file://0002-Enable-encrypted-boot-support.patch"

# Added to automate encryption with UUU tool
# SRC_URI += "file://0003-Add-fastboot-commands.patch"