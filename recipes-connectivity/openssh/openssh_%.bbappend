FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SYSTEMD_AUTO_ENABLE = "enable"

SRC_URI     += "                                                   \
                 file://sshddelkeys.sh                             \
                 file://sshdgenkeys.service.conf                   \
               "
FILES:${PN} += "                                                   \
                 ${sbindir}/sshddelkeys.sh                         \
                 ${systemd_unitdir}/system/sshdgenkeys.service.d/* \
               "

inherit bitbake-variable-substitution-helpers

do_install:append() {
    install -d                                          ${D}${sbindir}/
    install -m 0755 ${WORKDIR}/sshddelkeys.sh           ${D}${sbindir}/

    install -d                                          ${D}${systemd_unitdir}/system/sshdgenkeys.service.d/
    install -m 0644 ${WORKDIR}/sshdgenkeys.service.conf ${D}${systemd_unitdir}/system/sshdgenkeys.service.d/

    sed -i '/HostKey/d' ${D}${sysconfdir}/ssh/sshd_config
    grep    "HostKey"   ${D}${sysconfdir}/ssh/sshd_config_readonly >> ${D}${sysconfdir}/ssh/sshd_config

    ${@bitbake_variables_search_and_sub("${D}${sbindir}/sshddelkeys.sh"                       , r"${BITBAKE_VAR_SUB_DELIM}", d)}
    ${@bitbake_variables_search_and_sub("${D}${systemd_unitdir}/system/sshdgenkeys.service.d/", r"${BITBAKE_VAR_SUB_DELIM}", d)}
}
