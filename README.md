<!--
# File: README.md
# Author: Daniel Selvan, Jasmin Infotech
# Copyright (c) 2022 BG Networks, Inc.
#
# See LICENSE file for license details.
-->

# meta-bgn-essa

[BG Network's](https://bgnet.works/) [Embedded Security Software Architecture](https://bgnet.works/embedded-security-software-architecture/) (ESSA), a collection of scripts, recipes, configurations, and documentation for Linux, enhances cybersecurity for IoT devices, including secure boot, encryption, authentication, and secure software updates. The ESSA enables engineers to extend a hardware root of trust to secure U-Boot, the Linux kernel, and applications in the root file system.

This repository enables NXP's HAB features on UEI PDNASX6 hardware.

## Supported Board

The following board is the only board tested in this release.

- UEI PDNA SX6

## Quick Start Guide

See the Quick Start Guide for instructions on installing repo.

#### Build

_NOTE_: This integration is tested for `imx-image-minimal `

```bash
source setup-environment <build_folder>
bitbake imx-image-minimal
```

## Detailed Guide

To download a detailed guide to BG Networks ESSA click [here](https://bgnet.works/download-essa-user-guide/).

## Contributing

To contribute to the development of this BSP and/or submit patches for new boards please feel free to [create pull requests](https://github.com/bgnetworks/meta-bgn-essa/pulls).

## Building test image

To enable a developer/tester to easily flash multiple variations/boards, the test image is concentrating on the following aspects:

- Minimal size
- Minimal build time
- Traceability (build time)
- Easy access to components (No U-Boot & Linux passwords)

1. Use the latest BGN-ESSA layer at https://github.com/bgnetworks/meta-essa-uei6sx/tree/hardknott

2. Add the following lines on `conf/local.conf` file:
   ```bash
   TEST_BUILD = "1"
   ```
3. Run the `bitbake core-image-minimal` command

## Maintainer(s)

The author(s) and maintainer(s) of this layer is(are):

- Daniel Selvan D - <daniel.selvan@jasmin-infotech.com> - [danie007](https://github.com/danie007)
