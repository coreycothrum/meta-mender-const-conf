SUMMARY                = "restart rsyslogd when new conf.d files are detected"
DESCRIPTION            = "restart rsyslogd when new conf.d files are detected"
LICENSE                = "MIT"
LIC_FILES_CHKSUM       = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit systemd
inherit bitbake-variable-substitution

SYSTEMD_AUTO_ENABLE    = "enable"
SYSTEMD_SERVICE:${PN} += "rsyslog-watcher.path"

SRC_URI               += "                                \
                           file://rsyslog-watcher.service \
                           file://rsyslog-watcher.path    \
                         "
FILES:${PN}            = "                                                   \
                           ${systemd_unitdir}/system/rsyslog-watcher.service \
                           ${systemd_unitdir}/system/rsyslog-watcher.path    \
                         "

do_install:append() {
    install -d                                         ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/rsyslog-watcher.service ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/rsyslog-watcher.path    ${D}${systemd_unitdir}/system
}
