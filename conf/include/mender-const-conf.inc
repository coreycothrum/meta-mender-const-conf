#IMAGE_INSTALL_append                += "packagegroup-mender-const-conf"
INHERIT                             += "mender-const-conf-setup"

################################################################################
EXTRA_IMAGE_FEATURES_append         += "read-only-rootfs"

################################################################################
DISTRO_FEATURES_append              += "systemd"
DISTRO_FEATURES_BACKFILL_CONSIDERED += "sysvinit"
VIRTUAL-RUNTIME_login_manager        = "shadow-base"
VIRTUAL-RUNTIME_init_manager         = "systemd"
VIRTUAL-RUNTIME_initscripts          = "systemd-compat-units"
