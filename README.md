# meta-mender-const-conf

Preserve important stuff across [mender](https://github.com/mendersoftware/meta-mender) updates.

This is mostly symlinking stuff into the ``/data`` partition.

## Overview
``systemd`` is assumed/required.

* Generate SSH keys and store in ``/data``
* Generate SSL keys and store in ``/data``
* [systemd-hostnamed](#systemd-hostnamed) mapped to ``/data``
* [systemd-networkd](#systemd-networkd) mapped to ``/data``
* ``read-only-rootfs`` is enabled by default. There is no good reason not to use it.

### systemd-hostnamed
``/etc/hostname`` is symlinked to ``MENDER/CONST_CONF_HOSTNAME_CONF_DATA_DIR``.

When the new hostname file changes, ``systemd-hostnamed-watcher.service`` applies the hostname via ``hostnamectl``.

### systemd-networkd
All [systemd.netowrk](https://www.freedesktop.org/software/systemd/man/systemd.network.html) files (\*.network) are installed into ``MENDER/CONST_CONF_NETWORK_CONF_DATA_DIR`` (``/data`` partition).

This directory is mounted/merged (overlayfs) at ``/etc/systemd/network``, allowing dynamic and persistent network changes with a read-only filesystem.

When one of the systemd.network files change, ``systemd-networkd-watcher.service`` restarts ``systemd-networkd`` via ``systemctl`` to apply changes.

#### Install Custom Network Device Configuration
This layer only installs ``zdefault.network``, a catchall that sets the interface to unmanaged. This is so unused interfaces do not cause systemd to report failed services.

To add custom systemd.network files, append ``systemd-conf_%.bbappend`` to extend ``FILESEXTRAPATHS_prepend``. They are expected to be located at:

    ${WORKDIR}/network/*.network
    ${WORKDIR}/network/${MACHINE}/*.network

Any found will be added automatically.

Otherwise dynamically create files at runtime.

## Dependencies
This layer depends on:

    URI: git://git.openembedded.org/bitbake

    URI: git://git.openembedded.org/openembedded-core
    layers: meta
    branch: master

    URI: https://github.com/mendersoftware/meta-mender.git
    layers: meta-mender-core
    branch: master

    URI: https://github.com/coreycothrum/meta-bitbake-variable-substitution.git
    layers: meta-bitbake-variable-substitution
    branch: master

## Installation
### Add Layer to Build
In order to use this layer, the build system must be aware of it.

Assuming this layer exists at the top-level of the yocto build tree; add the location of this layer to ``bblayers.conf``, along with any additional layers needed:

    BBLAYERS ?= "                                       \
      /path/to/yocto/meta                               \
      /path/to/yocto/meta-poky                          \
      /path/to/yocto/meta-yocto-bsp                     \
      /path/to/yocto/meta-mender/meta-mender-core       \
      /path/to/yocto/meta-bitbake-variable-substitution \
      /path/to/yocto/meta-mender-const-conf             \
      "

Alternatively, run bitbake-layers to add:

    $ bitbake-layers add-layer /path/to/yocto/meta-mender-const-conf

### Configure Layer
The following definitions should be added to ``local.conf`` or ``custom_machine.conf``

    require conf/include/mender-const-conf.inc

#### kas
Alternatively, a [kas](https://github.com/siemens/kas) file has been provided to help with setup/config. [Include](https://kas.readthedocs.io/en/latest/userguide.html#including-configuration-files-from-other-repos) `kas/kas.yml` from this layer in the top level kas file. E.g.:

    header:
      version : 1
      includes:
        - repo: meta-mender-const-conf
          file: kas/kas.yml

## Contributing
Please submit any patches against this layer via pull request.

Commits must be signed off.

Use [conventional commits](https://www.conventionalcommits.org/).
