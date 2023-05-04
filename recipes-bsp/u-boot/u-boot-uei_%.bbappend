FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# HAB Features
SRC_URI += "file://0001-Enable-secure-boot-support.patch"

# Fastboot for UUU tool
SRC_URI += "file://0002-Add-fastboot-support-for-UUU-tool.patch"

# UEI doesn't require U-Boot encrypted, hence disabled by default
SRC_URI += "file://0003-Enable-encrypted-boot-support.patch"

# TEMP: Enable CAAM Driver
SRC_URI += "file://0004-Add-CAAM-driver-support.patch"

# Test build
SRC_URI += "${@bb.utils.contains('TEST_BUILD', '1', 'file://0006-Remove-password-for-test-build.patch', '', d)}"

# WGET support
SRC_URI += "file://0007-Add-TCP-wget-command.patch"

SRC_URI += "file://0008-Added-non-standard-TFTP-port.patch"

SRC_URI += "file://0009-Added-HAB-authentication-for-uCOS-boot.patch"
