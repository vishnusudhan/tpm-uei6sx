#!/bin/bash

DEV=/dev/ttymxc0
BAUDRATE=57600

stty -F $DEV $BAUDRATE
sz /data/caam/enckey.bb >$DEV <$DEV