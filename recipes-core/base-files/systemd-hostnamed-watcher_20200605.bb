SUMMARY                = "setup hostname after persistent FS has been mounted"
DESCRIPTION            = "setup hostname after persistent FS has been mounted"
LICENSE                = "MIT"
LIC_FILES_CHKSUM       = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit systemd
inherit bitbake-variable-substitution

SYSTEMD_AUTO_ENABLE    = "enable"
SYSTEMD_SERVICE_${PN} += "systemd-hostnamed-watcher.service"
SYSTEMD_SERVICE_${PN} += "systemd-hostnamed-watcher.path"

SRC_URI               += "                                                             \
                           file://systemd-hostnamed-watcher.service                    \
                           file://systemd-hostnamed-watcher.path                       \
                         "
FILES_${PN}            = "                                                             \
                           ${systemd_unitdir}/system/systemd-hostnamed-watcher.service \
                           ${systemd_unitdir}/system/systemd-hostnamed-watcher.path    \
                         "
RDEPENDS_${PN}         = "coreutils"

do_install_append() {
    install -d                                                   ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/systemd-hostnamed-watcher.service ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/systemd-hostnamed-watcher.path    ${D}${systemd_unitdir}/system
}
