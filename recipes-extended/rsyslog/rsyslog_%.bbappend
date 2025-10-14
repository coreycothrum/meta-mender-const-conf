FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

FILES:${PN} += "            \
  ${sysconfdir}/rsyslog.d/* \
"

SRC_URI += "                         \
  file://include_const_data_dir.conf \
"

RDEPENDS:${PN} = "rsyslog-watcher"

inherit bitbake-variable-substitution-helpers

do_install:append() {
    install -d                                              ${D}${sysconfdir}/rsyslog.d/
    install -m 0644 ${WORKDIR}/include_const_data_dir.conf  ${D}${sysconfdir}/rsyslog.d/
    ${@bitbake_variables_search_and_sub(                   "${D}${sysconfdir}/rsyslog.d/", r"${BITBAKE_VAR_SUB_DELIM}", d)}
}
