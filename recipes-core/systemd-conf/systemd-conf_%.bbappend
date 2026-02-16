FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

RDEPENDS:${PN} += "systemd-networkd-watcher"

SRC_URI += " \
  file://systemd-tmpfiles-setup.service.conf \
  file://systemd-networkd.service.conf \
"
FILES:${PN} += " \
  ${MENDER/CONST_CONF_NETWORK_CONF_DATA_DIR} \
  ${sysconfdir}/systemd/network/* \
  ${systemd_unitdir}/system/systemd-tmpfiles-setup.service.d/* \
  ${systemd_unitdir}/system/systemd-networkd.service.d/* \
"

PACKAGECONFIG = "dhcp-ethernet"

inherit bitbake-variable-substitution

do_install:append() {
    install -d                                                     ${D}${systemd_unitdir}/system/systemd-tmpfiles-setup.service.d/
    install -m 0644 ${WORKDIR}/systemd-tmpfiles-setup.service.conf ${D}${systemd_unitdir}/system/systemd-tmpfiles-setup.service.d/

    install -d                                                     ${D}${systemd_unitdir}/system/systemd-networkd.service.d/
    install -m 0644 ${WORKDIR}/systemd-networkd.service.conf       ${D}${systemd_unitdir}/system/systemd-networkd.service.d/

    install -d                                                     ${D}${MENDER/CONST_CONF_NETWORK_CONF_DATA_DIR}/
    install -d                                                     ${D}${sysconfdir}/systemd/network/
}
