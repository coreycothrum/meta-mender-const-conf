SUMMARY          = "load archived docker image(s)"
DESCRIPTION      = "load archived docker image(s)"
LICENSE          = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

################################################################################
SYSTEMD_AUTO_ENABLE   = "enable"
SYSTEMD_SERVICE:${PN} = " \
    ${BPN}.service \
    ${BPN}.path \
"
SRC_URI += " \
  file://${BPN}.service \
  file://${BPN}.path \
"
FILES:${PN} += " \
  ${systemd_unitdir}/system/${BPN}.service \
  ${systemd_unitdir}/system/${BPN}.path \
"

RDEPENDS:${PN} += " \
  bash \
  docker \
"

inherit bitbake-variable-substitution-helpers
inherit systemd

do_install:append() {
  install -d                              ${D}${systemd_unitdir}/system/
  install    -m 0644 ${WORKDIR}/*.service ${D}${systemd_unitdir}/system/
  install    -m 0644 ${WORKDIR}/*.path    ${D}${systemd_unitdir}/system/

  ${@bitbake_variables_search_and_sub("${D}${systemd_unitdir}/system/", r"${BITBAKE_VAR_SUB_DELIM}", d)}
}
