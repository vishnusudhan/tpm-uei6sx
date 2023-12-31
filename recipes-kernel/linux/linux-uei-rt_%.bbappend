FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# Dm-crypt fragment for 5.10 kernel
SRC_URI += "file://0001-device-mapper-and-crypt-target.cfg"
SRC_URI += "file://0002-caam-black-key-driver.cfg"
SRC_URI += "file://0003-cryptographic-API-functions.cfg"

do_configure_append() {
    cat ../*.cfg >>${B}/.config
}
