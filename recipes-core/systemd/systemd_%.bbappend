# Dirty fix: Overwriting UEI's static IP for DHCP configuration
# TODO: Add priority based conditional update on separate location
do_install_append() {
    cat >${D}${sysconfdir}/systemd/network/20-wired.network <<EOF
[Match]
Name=eth0
KernelCommandLine=!nfsroot

[Network]
DHCP=ipv4

[DHCPv4]
UseHostname=false
EOF
}
