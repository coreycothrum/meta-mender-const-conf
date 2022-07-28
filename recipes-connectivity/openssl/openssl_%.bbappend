FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI     += "                                              \
                 file://95-sslgenkeys.preset                  \
                 file://sslgenkeys.service                    \
                 file://sslgenkeys.sh                         \
                 file://ssldelkeys.sh                         \
               "
FILES:${PN} += "                                              \
                 ${systemd_unitdir}/system-preset/*           \
                 ${systemd_unitdir}/system/sslgenkeys.service \
                 ${sbindir}/sslgenkeys.sh                     \
                 ${sbindir}/ssldelkeys.sh                     \
               "

inherit bitbake-variable-substitution-helpers

do_install:append() {
    install -d                                     ${D}${systemd_unitdir}/system-preset/
    install -m 644 ${WORKDIR}/95-sslgenkeys.preset ${D}${systemd_unitdir}/system-preset/

    install -d                                     ${D}${sbindir}/
    install -m 755 ${WORKDIR}/sslgenkeys.sh        ${D}${sbindir}/
    install -m 755 ${WORKDIR}/ssldelkeys.sh        ${D}${sbindir}/

    install -d                                     ${D}${systemd_unitdir}/system/
    install -m 0644 ${WORKDIR}/sslgenkeys.service  ${D}${systemd_unitdir}/system/

    ${@bitbake_variables_search_and_sub(          "${D}${systemd_unitdir}/system/sslgenkeys.service", r"${BITBAKE_VAR_SUB_DELIM}", d)}
    ${@bitbake_variables_search_and_sub(          "${D}${sbindir}/sslgenkeys.sh"                    , r"${BITBAKE_VAR_SUB_DELIM}", d)}
    ${@bitbake_variables_search_and_sub(          "${D}${sbindir}/ssldelkeys.sh"                    , r"${BITBAKE_VAR_SUB_DELIM}", d)}
}
