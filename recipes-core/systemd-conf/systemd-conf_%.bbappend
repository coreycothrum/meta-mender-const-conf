FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

RDEPENDS_${PN} += "systemd-networkd-watcher"

SRC_URI     += "                                                        \
                 file://network/                                        \
                 file://systemd-networkd.service.conf                   \
               "
FILES_${PN} += "                                                        \
                 ${MENDER/CONST_CONF_NETWORK_CONF_DATA_DIR}/*           \
                 ${sysconfdir}/systemd/network/*                        \
                 ${systemd_unitdir}/system/systemd-networkd.service.d/* \
               "

do_install_append() {
    install -d                                               ${D}${systemd_unitdir}/system/systemd-networkd.service.d/
    install -m 0644 ${WORKDIR}/systemd-networkd.service.conf ${D}${systemd_unitdir}/system/systemd-networkd.service.d/

    install -d                                   ${D}${MENDER/CONST_CONF_NETWORK_CONF_DATA_DIR}/
    install -m 0644 ${WORKDIR}/network/*.network ${D}${MENDER/CONST_CONF_NETWORK_CONF_DATA_DIR}/
    for file in                                  ${D}${MENDER/CONST_CONF_NETWORK_CONF_DATA_DIR}/*.network
    do
      install -d     ${D}${sysconfdir}/systemd/network/
      lnr     $file  ${D}${sysconfdir}/systemd/network/05-$(basename $file)
    done
}
