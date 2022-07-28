EXTRA_IMAGE_FEATURES:append = " read-only-rootfs"

python do_mender_const_conf_checks() {
  if not bb.utils.contains('DISTRO_FEATURES', 'systemd', True, False, d):
    bb.fatal("mender-const-conf requires systemd")
 
  if not bb.utils.contains(      'IMAGE_FEATURES', 'read-only-rootfs', True, False, d) and \
     not bb.utils.contains('EXTRA_IMAGE_FEATURES', 'read-only-rootfs', True, False, d):
    bb.warn("read-only-rootfs is not enabled. Consider extending mender-const-conf instead.")
}
addhandler do_mender_const_conf_checks
do_mender_const_conf_checks[eventmask] = "bb.event.ParseCompleted"
