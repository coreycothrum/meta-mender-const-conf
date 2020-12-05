FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

RDEPENDS_${PN}          += "systemd-hostnamed-watcher"

do_install_append() {
  install -d                            ${D}${MENDER/CONST_CONF_HOSTNAME_CONF_DATA_DIR}
  mv         ${D}${sysconfdir}/hostname ${D}${MENDER/CONST_CONF_HOSTNAME_CONF_DATA_DIR}/hostname
  lnr                                   ${D}${MENDER/CONST_CONF_HOSTNAME_CONF_DATA_DIR}/hostname ${D}${sysconfdir}/hostname
}
