INHERIT                             += "mender-const-conf-setup"

################################################################################
PREFERRED_RPROVIDER_ssh             ?= "openssh"

################################################################################
EXTRA_IMAGE_FEATURES:append          = " read-only-rootfs"

################################################################################
DISTRO_FEATURES:append               = " systemd"
DISTRO_FEATURES_BACKFILL_CONSIDERED += "sysvinit"
VIRTUAL-RUNTIME_login_manager        = "shadow-base"
VIRTUAL-RUNTIME_init_manager         = "systemd"
VIRTUAL-RUNTIME_initscripts          = "systemd-compat-units"
