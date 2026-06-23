INHERIT += "mender-const-conf-setup"

PREFERRED_RPROVIDER_ssh ?= "openssh"

EXTRA_IMAGE_FEATURES:append = " read-only-rootfs"
