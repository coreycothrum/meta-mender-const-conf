FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

RDEPENDS_${PN} += "systemd-hostnamed-watcher"

SRC_URI        += "                                                         \
                    file://systemd-hostnamed.service.conf                   \
                  "
FILES_${PN}    += "                                                         \
                    ${MENDER/CONST_CONF_HOSTNAME_CONF_DATA_DIR}/*           \
                    ${systemd_unitdir}/system/systemd-hostnamed.service.d/* \
                  "

do_install_append() {
  install -d                                                ${D}${systemd_unitdir}/system/systemd-hostnamed.service.d/
  install -m 0644 ${WORKDIR}/systemd-hostnamed.service.conf ${D}${systemd_unitdir}/system/systemd-hostnamed.service.d/

  install -d                            ${D}${MENDER/CONST_CONF_HOSTNAME_CONF_DATA_DIR}
  mv         ${D}${sysconfdir}/hostname ${D}${MENDER/CONST_CONF_HOSTNAME_CONF_DATA_DIR}/hostname
  lnr                                   ${D}${MENDER/CONST_CONF_HOSTNAME_CONF_DATA_DIR}/hostname ${D}${sysconfdir}/hostname
}
