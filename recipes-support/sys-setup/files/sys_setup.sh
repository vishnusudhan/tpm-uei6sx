#!/bin/bash
#
# sys_setup.sh
# Encrypt a block with CAAM black key and create services to automount on startup
#
# 21.06.2022
# Daniel Selvan, Jasmin Infotech

###################################################################################################

#           Configuring Crypt block

###################################################################################################

s_block="/dev/mmcblk2p3" # eMMC on UEI PDNA-SX6-RT
mpoint="/dmblk"

[ -e $s_block ] && {

    # (Optional) unmounting & closing the encrypted block
    umount $mpoint 2>/dev/null
    dmsetup remove -f crypt_target 2>/dev/null

    # Creating a random black key
    output=$(caam-keygen create enckey ecb -s 16 2>&1)

    if [ $? -ne 0 ] || [[ $output =~ "usage" ]]; then
        echo "ERROR: caam-keygen failed!"

        echo "Exiting..."
        return 1
    fi

    # Adding the black key in kernel keyring
    cat /data/caam/enckey | keyctl padd logon enckey: @s

    # Deleting the black key (NOTE: Black key blob is preserved)
    rm -f /data/caam/enckey

    # Wiping the block to be encrypted
    dd if=/dev/zero of=$s_block bs=1M count=32

    # Encrypting the block with CAAM's black key
    dmsetup -v create crypt_target --table "0 $(blockdev --getsz $s_block) crypt capi:tk(cbc(aes))-plain :36:logon:enckey: 0 $s_block 0 1 sector_size:512"

    # Creating a filesystem on the encrypted block
    mkfs.ext4 /dev/mapper/crypt_target

    # Mounting the encrypted block
    mkdir -p $mpoint
    mount /dev/mapper/crypt_target $mpoint

    echo Creating auto mount service

    cat >/usr/crypt_target.sh <<EOF
#!/bin/bash

cd /data/caam

# Importing the generated random black key
caam-keygen import enckey.bb enckey

# Adding the black key in kernel keyring
cat enckey | keyctl padd logon enckey: @s

# Deleting the imported black key
rm -f enckey

cd

# Opening the block with CAAM's black key
dmsetup -v create crypt_target --table "0 $(blockdev --getsz $s_block) crypt capi:tk(cbc(aes))-plain :36:logon:enckey: 0 $s_block 0 1 sector_size:512"

# Mounting the encrypted block
mkdir -p $mpoint
mount /dev/mapper/crypt_target $mpoint
EOF

    # Deny access for others
    chmod 500 /usr/crypt_target.sh

    cat >/etc/systemd/system/crypt-target.service <<EOF
[Unit]
Description=Import black key from the black key blob, set it in the kernel keyring, open the DM-Crypt partition with black key and mounts it
DefaultDependencies=yes
Conflicts=shutdown.target
Requires=systemd-modules-load.service
After=local-fs.target systemd-modules-load.service
OnFailure=emergency.target
OnFailureJobMode=replace-irreversibly
Before=rc-local.service
[Service]
Type=oneshot
ExecStart=/usr/crypt_target.sh
TimeoutStartSec=90
[Install]
WantedBy=default.target
RequiredBy=rc-local.service systemd-logind.service
EOF

    # Deny access for others (Read Only)
    chmod 644 /etc/systemd/system/crypt-target.service

    echo Enabling auto mount service
    systemctl daemon-reload
    systemctl enable crypt-target.service
    ###################################################################################################
} || echo " Create a block to encrypt it"
